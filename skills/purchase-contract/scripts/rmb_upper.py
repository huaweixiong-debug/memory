# -*- coding: utf-8 -*-
"""人民币金额转大写。用法: python rmb_upper.py 1200 -> 壹仟贰佰元整"""
import sys

DIGITS = '零壹贰叁肆伍陆柒捌玖'
UNITS = ['', '拾', '佰', '仟']
GROUPS = ['', '万', '亿', '兆']

def rmb_upper(n: float) -> str:
    n = round(n + 1e-9, 2)
    if n == 0:
        return '零元整'
    neg = n < 0
    n = abs(n)
    zheng = int(n)
    fen = round((n - zheng) * 100)
    jiao, fen_div = divmod(fen, 10)

    parts = []
    if zheng:
        s = str(zheng)
        groups = []
        while s:
            groups.insert(0, s[-4:])
            s = s[:-4]
        out = []
        for gi, g in enumerate(groups):
            g = g.zfill(4)
            piece = ''
            zero_pending = False
            for i, ch in enumerate(g):
                d = int(ch)
                u = UNITS[3 - i]
                if d == 0:
                    zero_pending = True
                else:
                    if zero_pending and piece:
                        piece += '零'
                    piece += DIGITS[d] + u
                    zero_pending = False
            if piece:
                piece += GROUPS[len(groups) - 1 - gi]
                # 组间补零：前一组小于1000且后组存在
            out.append(piece)
        # 组间零处理
        result = ''
        for gi, piece in enumerate(out):
            if not piece:
                continue
            if result and int(groups[gi].zfill(4)) < 1000:
                result += '零'
            result += piece
        parts.append(result + '元')

    if jiao == 0 and fen_div == 0:
        parts.append('整')
    else:
        if zheng and jiao == 0:
            parts.append('零')
        if jiao:
            parts.append(DIGITS[jiao] + '角')
        if fen_div:
            parts.append(DIGITS[fen_div] + '分')
    s = ('负' if neg else '') + ''.join(parts)
    return s

if __name__ == '__main__':
    print(rmb_upper(float(sys.argv[1])))
