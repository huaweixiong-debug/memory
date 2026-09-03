# -*- coding: utf-8 -*-
"""基于一次性采购合同模板生成新合同。

流程（在本机 Windows + WPS 环境验证过）：
1. KWPS.COM 打开模板 -> 接受全部修订 -> 关闭修订跟踪
2. 全局查找替换（注意：WPS COM 不支持命名参数，Execute 必须全位置传参，
   否则 Replace 被静默忽略、只查不改）
3. 单元格级替换：纠正模板中"数量/单位"填反的列
4. 另存 docx + 导出 PDF
5. 字体统一：被替换的 run 不会继承原字体，用 python-docx 补 rPr（宋体 12pt）
"""
import argparse
import os
import sys


def build_parser():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument('--template', required=True)
    p.add_argument('--output', required=True)
    p.add_argument('--pdf', default=None)
    p.add_argument('--old-product', required=True)
    p.add_argument('--new-product', required=True)
    p.add_argument('--old-part-no', default=None, help='旧协众件号，替换为空待用户补填')
    p.add_argument('--new-part-no', default='')
    p.add_argument('--old-qty-word', default=None, help='如"订购一套"')
    p.add_argument('--new-qty-word', default=None, help='如"订购二套"')
    p.add_argument('--new-unit', default='套', help='产品表单位列')
    p.add_argument('--new-qty', default=None, help='产品表数量列，如"2"')
    p.add_argument('--old-untaxed', required=True)
    p.add_argument('--new-untaxed', required=True)
    p.add_argument('--old-upper', required=True, help='旧大写金额，如"肆万伍仟元整"')
    p.add_argument('--new-upper', required=True)
    p.add_argument('--old-total', required=True)
    p.add_argument('--new-total', required=True)
    p.add_argument('--font', default='宋体')
    p.add_argument('--font-size-half-pt', default='24', help='半磅值，24=12pt')
    return p


# ---------- 第 1~4 步：WPS COM ----------

def run_com_replacements(args):
    import win32com.client

    if os.path.exists(args.output):
        os.remove(args.output)

    word = win32com.client.Dispatch('KWPS.Application')
    word.Visible = False
    word.DisplayAlerts = 0
    try:
        doc = word.Documents.Open(args.template, ReadOnly=True, AddToRecentFiles=False)
        try:
            doc.AcceptAllRevisions()
        except Exception:
            doc.Revisions.AcceptAll()
        doc.TrackRevisions = False

        def replace_all(find, repl):
            f = doc.Content.Find
            f.ClearFormatting()
            f.Replacement.ClearFormatting()
            ok = f.Execute(find, True, False, False, False, False, True, 1, False, repl, 2)
            print(f"  replace {find!r} -> {repl!r}: {'done' if ok else 'NOT FOUND'}")
            return ok

        # 顺序：长名称（带后缀）优先，避免短串先命中破坏长串
        old_names = args.old_product.split('|')
        for old in sorted(old_names, key=len, reverse=True):
            replace_all(old, args.new_product)
        if args.old_part_no:
            replace_all(args.old_part_no, args.new_part_no)
        if args.old_qty_word and args.new_qty_word:
            replace_all(args.old_qty_word, args.new_qty_word)
        replace_all(args.old_untaxed, args.new_untaxed)
        replace_all(args.old_upper, args.new_upper)
        replace_all(args.old_total, args.new_total)

        # 产品表第 1 行（表头为 row1）：纠正 单位/数量 填反的列
        if args.new_qty:
            try:
                tbl = doc.Tables(1)
                # 模板中两列的旧值：单位列="1"、数量列="套"
                for col, old, new in ((3, '1', args.new_unit),
                                      (4, '套', args.new_qty)):
                    r = tbl.Cell(2, col).Range
                    r.End = r.End - 1  # 排除单元格结束符
                    f = r.Find
                    f.ClearFormatting()
                    f.Replacement.ClearFormatting()
                    ok = f.Execute(old, True, False, False, False, False, True, 0, False, new, 2)
                    print(f"  cell({2},{col}) {old!r}->{new!r}: {'done' if ok else 'NOT FOUND'}")
            except Exception as e:
                print(f"  table cell fix skipped: {e}")

        doc.SaveAs2(args.output, FileFormat=16)
        if args.pdf:
            try:
                doc.ExportAsFixedFormat(args.pdf, 17)
            except Exception:
                doc.SaveAs2(args.pdf, FileFormat=17)
        doc.Close(False)
        print('saved:', args.output)
    finally:
        word.Quit()


# ---------- 第 5 步：字体统一 ----------

def normalize_fonts(args):
    import docx
    from docx.oxml.ns import qn
    from lxml import etree

    W = 'http://schemas.openxmlformats.org/wordprocessingml/2006/main'
    targets = {args.new_product, args.new_untaxed, args.new_upper, args.new_total,
               args.new_qty_word, args.new_part_no, args.new_unit, args.new_qty}

    doc = docx.Document(args.output)

    def make_rpr():
        rPr = etree.Element(f'{{{W}}}rPr')
        rf = etree.SubElement(rPr, f'{{{W}}}rFonts')
        for a in ('ascii', 'hAnsi', 'eastAsia'):
            rf.set(f'{{{W}}}{a}', args.font)
        for tag in ('sz', 'szCs'):
            e = etree.SubElement(rPr, f'{{{W}}}{tag}')
            e.set(f'{{{W}}}val', args.font_size_half_pt)
        return rPr

    fixed = 0

    def walk_runs(parent_elm):
        nonlocal fixed
        for r in parent_elm.iter(qn('w:r')):
            txt = ''.join(t.text or '' for t in r.findall(qn('w:t')))
            if txt.strip() and txt.strip() in targets:
                old = r.find(qn('w:rPr'))
                if old is not None:
                    r.remove(old)
                r.insert(0, make_rpr())
                fixed += 1

    body = doc.element.body
    walk_runs(body)
    for t in doc.tables:
        walk_runs(t._tbl)
    doc.save(args.output)
    print(f'fonts normalized on {fixed} runs')


def verify(args):
    """断言旧内容零残留、新内容存在。"""
    import zipfile, re
    z = zipfile.ZipFile(args.output)
    joined = ''
    for name in z.namelist():
        if name.startswith('word/') and name.endswith('.xml'):
            xml = z.read(name).decode('utf-8', 'ignore')
            joined += ''.join(re.findall(r'<w:t(?:\s[^>]*)?>([^<]*)</w:t>', xml))
    fails = []
    for old in filter(None, [args.old_product, args.old_part_no, args.old_untaxed,
                             args.old_upper, args.old_total]):
        if old and old in joined:
            fails.append(f'旧内容残留: {old!r}')
    for new in [args.new_product, args.new_untaxed, args.new_upper, args.new_total]:
        if new not in joined:
            fails.append(f'新内容缺失: {new!r}')
    xml = z.read('word/document.xml').decode('utf-8', 'ignore')
    if '<w:ins ' in xml or '<w:del ' in xml:
        fails.append('仍有修订痕迹')
    if fails:
        print('VERIFY FAIL:')
        for f_ in fails:
            print(' -', f_)
        sys.exit(1)
    print('VERIFY PASS')


if __name__ == '__main__':
    args = build_parser().parse_args()
    run_com_replacements(args)
    normalize_fonts(args)
    verify(args)
