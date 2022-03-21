#!/bin/bash
cnNums=("零" "一" "二" "三" "四" "五" "六" "七" "八" "九")
cnIntRadice=("" "十" "百" "千")
cnIntUnits=("" "万" "亿")
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
    q=$(($p / 4))
    m=$(($p % 4))
    if [[ $n = 0 ]]; then
        zeroCount+=1
    else
        if [[ $zeroCount > 0 ]]; then
            cnIntegerNum+=${cnNums[0]}
        fi
        zeroCount=0
        cnIntegerNum+=${cnNums[$n]}${cnIntRadice[$m]}
    fi
    if [[ $m = 0 ]] && [[ $zeroCount < 4 ]]; then
        cnIntegerNum+=${cnIntUnits[$q]}
    fi
done
if [[ $cnIntegerNum = "" ]]; then
    cnIntegerNum="零"
fi
echo $cnIntegerNum$cnDecimalNum
