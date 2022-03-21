#!/bin/bash
cnNums=("零" "一" "二" "三" "四" "五" "六" "七" "八" "九")
cnIntRadice=("" "十" "百" "千")
cnIntUnits=("" "亿" "亿亿" "京" "垓" "穰" "穰" "沟" "涧" "正" "载" "极" "恒河沙" "阿僧祇" "那由他" "不可思议" "净" "清" "空")
cnIntegerNum=""
case $1 in
*"."*)
    DecimalNum=${1/*./}
    cnDecimalNum="点"
    for ((i = 0; $i < ${#DecimalNum}; i = $i + 1)); do
        cnDecimalNum+=${cnNums[${DecimalNum:$i:1}]}
    done
    ;;
*) cnDecimalNum="" ;;
esac
IntegerNum=${1/.*/}
zeroCount=0
for ((i = 0; $i < ${#IntegerNum}; i = $i + 1)); do
    n=${IntegerNum:$i:1}
    p=$((${#IntegerNum} - $i - 1))
    r=$(($p / 8))
    q=$(($p % 8))
    m=$(($p % 4))
    if [[ $n = 0 ]]; then
        zeroCount=$(($zeroCount + 1))
    else
        if [[ $zeroCount -gt 0 ]]; then
            cnIntegerNum+=${cnNums[0]}
        fi
        zeroCount=0
        cnIntegerNum+=${cnNums[$n]}${cnIntRadice[$m]}
    fi
    if [[ $m -eq 0 ]] && [[ $zeroCount -lt 4 ]]; then
        if [[ $q = 4 ]]; then
            cnIntegerNum+="万"
        fi
        if [[ $q -eq 0 ]]; then
            cnIntegerNum+=${cnIntUnits[$r]}
        fi
    fi

done
if [[ $cnIntegerNum = "" ]]; then
    cnIntegerNum="零"
fi
echo $cnIntegerNum$cnDecimalNum
