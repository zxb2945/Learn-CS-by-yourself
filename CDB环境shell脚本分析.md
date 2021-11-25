## CDB环境shell脚本分析

## CreateDB.sh

```shell
# Debug Flag
#DEBUGFLAG=1

# CDB/RDB Flag
DEF_CDB__FLAG=0
DEF_RDB__FLAG=1
NOW_TEST_FLAG=${DEF_CDB__FLAG}      
#********************************************************
# Q&A:上式非得用花括号吗？ 至少有这样的形式：A=$(ls)
# 一般情况下，$var与${var}是没有区别的，但是用${ }会比较精确的界定变量名称的范围。
#********************************************************

# Tool Path
TOOLPATH=`dirname $0`
# Tool Name
TOOLNAME=`basename $0`
# InputParameter Counter
#********************************************************
# Q&A:dirname 与 basename: 
# dirname $0，取得当前执行的脚本文件的父目录
# `basename $0`值显示当前脚本或命令的名字
# $0显示会包括当前脚本或命令的路径
#********************************************************
INPARA_CNT=${#}
# Load Sub Function
source ${TOOLPATH}/CreateDB_FUNC.sh

# Data
# Paraterm MAX
CREPARA_MAX=6
BEFPARA_MAX=4
MIDPARA_MAX=4
AFTPARA_MAX=3
# Base Data
_FSCP_NM_=""
_STEP____=""
_MSN_____=""
_IMUI____=""
_TYPE____=""
_PATTERN_=""
# STEP Data
DEF_STEP_CRE=0
DEF_STEP_BEF=1
DEF_STEP_MID=2
DEF_STEP_AFT=3
# NSMA TYPE
DEF_NSMA_CLR=0
DEF_NSMA_SET=1
#
# Lock/Unlock Patern
#   TMNO:759,TMNO:752,TMNO:763,TMNO:401,TMNO:414,PMNO:750,PMNO:761,PMNO:363,TMNO:325,TMNO:309,TMNO:321,PMNO:573
LCK_PTN=(0,0,0,0,0,0,0,0,0,0,0,0
1,1,1,1,1,1,0,0,0,1,0,0
1,1,1,0,0,1,0,0,0,1,0,0
1,0,0,1,1,1,0,0,0,1,0,0
1,0,0,0,0,1,0,0,0,1,0,0
0,0,0,1,1,1,0,0,0,1,0,0
0,0,0,0,0,1,0,0,0,1,0,0
0,0,0,1,1,0,0,0,0,1,0,0
1,0,1,0,0,1,0,0,0,1,0,0
0,0,0,1,1,1,1,1,0,1,0,0
0,0,0,1,1,1,1,2,0,1,0,0
0,0,0,1,1,1,1,3,0,1,0,0
1,0,1,0,0,1,0,0,1,1,0,0
0,0,0,1,1,0,0,0,1,1,0,0
0,0,0,0,0,0,0,0,1,1,0,0
1,0,1,0,0,1,0,0,0,0,0,0
0,0,0,1,1,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0,0,0,0,0
1,0,1,0,0,1,0,0,0,1,1,0
0,0,0,1,1,0,0,0,0,1,1,0
0,0,0,0,0,0,0,0,0,1,1,0
1,0,1,0,0,1,0,0,0,1,0,2
)
#********************************************************
# Q&A:shell中的数组是怎样的形式？？
# shell中，用小括号( )来表示数组，数组元素之间用空格来分隔
# 常用的Bash shell只支持一维数组，不支持多维数组
# 获取数组中的元素要使用下标[ ]，下标可以是一个整数，也可以是一个结果为整数的表达式；下标必须大于等于0
# 赋值号=两边不能有空格，必须紧挨着数组名和数组元素
# 因为数组本质上还是变量，因此可以通过 unset 数组[下标] 删除相应的数组元素

# 据此，本shell中其实“1,1,1,1,1,1,0,0,0,1,0,0”作为一个元素
#********************************************************
LCK_PTN_CNT=`expr ${#LCK_PTN[@]} - 1`
#********************************************************
# Q&A:上述表达式做了什么？
# 打印全部数组内容：${数组名[@]}或 ${数组名[*]}，
# 打印数组元素的个数：${#数组名[@]}或 ${#数组名[*]}
# expr 就是中缀表达式（一般用于整数值，但也可用于字符串）
# 综上，LCK_PTN_CNT就是数组末尾下标值
#********************************************************
#
# WIPE Pattern
#   TMNO:759,TMNO:752,TMNO:763,TMNO:401,TMNO:414,PMNO:750,TMNO:761,PMNO:363,PMNO:460,PMNO:301,TMNO:325,TMNO:333,TMNO:308,TMNO:310,TMNO:322,PMNO:573
WPE_PTN=(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
1,1,1,1,1,1,0,0,0,0,0,0,1,1,0,0
1,1,1,0,0,1,0,0,0,0,0,0,1,1,0,0
1,0,0,1,1,1,0,0,0,0,0,0,1,1,0,0
1,0,0,0,0,1,0,0,0,0,0,0,1,1,0,0
0,0,0,1,1,1,0,0,0,0,0,0,1,1,0,0
0,0,0,0,0,1,0,0,0,0,0,0,1,1,0,0
0,0,0,1,1,0,0,0,0,0,0,0,1,1,0,0
1,0,1,0,0,1,0,0,0,0,0,0,1,1,0,0
0,0,0,1,1,1,1,1,0,0,0,0,1,1,0,0
0,0,0,1,1,1,1,2,0,0,0,0,1,1,0,0
0,0,0,1,1,1,1,3,0,0,0,0,1,1,0,0
0,0,0,1,1,1,0,0,1,0,0,0,1,1,0,0
0,0,0,1,1,0,0,0,1,0,0,0,1,1,0,0
1,0,1,0,0,1,0,0,1,0,0,0,1,1,0,0
0,0,0,1,1,1,1,1,1,0,0,0,1,1,0,0
0,0,0,1,1,1,0,0,2,0,0,0,1,1,0,0
0,0,0,1,1,0,0,0,2,0,0,0,1,1,0,0
1,0,1,0,0,1,0,0,2,0,0,0,1,1,0,0
0,0,0,1,1,1,1,1,2,0,0,0,1,1,0,0
1,0,1,0,0,1,0,0,0,0,1,0,1,1,0,0
0,0,0,1,1,0,0,0,0,0,1,0,1,1,0,0
0,0,0,0,0,0,0,0,0,0,1,0,1,1,0,0
1,0,1,0,0,1,0,0,0,0,0,1,1,1,0,0
0,0,0,1,1,0,0,0,0,0,0,1,1,1,0,0
0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0
1,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0
0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
1,0,1,0,0,1,0,0,0,0,0,0,0,1,1,0
0,0,0,1,1,0,0,0,0,0,0,0,0,1,1,0
0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0
1,0,1,0,0,1,0,0,0,1,1,0,1,1,0,0
0,0,0,1,1,0,0,0,0,1,1,0,1,1,0,0
0,0,0,0,0,0,0,0,0,1,1,0,1,1,0,0
1,0,1,0,0,1,0,0,0,1,0,0,0,1,0,0
0,0,0,1,1,0,0,0,0,1,0,0,0,1,0,0
0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0
1,0,1,0,0,1,0,0,0,2,0,1,1,1,0,0
0,0,0,1,1,0,0,0,0,2,0,1,1,1,0,0
0,0,0,0,0,0,0,0,0,2,0,1,1,1,0,0
1,0,1,0,0,1,0,0,0,2,0,0,1,0,0,0
0,0,0,1,1,0,0,0,0,2,0,0,1,0,0,0
0,0,0,0,0,0,0,0,0,2,0,0,1,0,0,0
1,0,1,0,0,1,0,0,0,2,0,0,1,1,1,0
0,0,0,1,1,0,0,0,0,2,0,0,1,1,1,0
0,0,0,0,0,0,0,0,0,2,0,0,1,1,1,0
1,0,1,0,0,1,0,0,0,0,0,0,1,1,0,2
)
WPE_PTN_CNT=`expr ${#WPE_PTN[@]} - 1`
#
# ReSEND Pattern
#   THSC_759,THSC_752,THSC_763,THSC_401,THSC_414,PHSC_750,THSC_761,PHSC_363,PHSC_460,PHSC_435,PHSC_436,PHSC_301,THSC_325,THSC_308,THSC_321,PHSC_461,THSC_366_476,RegSMDO,HSC_573,PHSC_422,Sdm-IF
#
RSN_PTN=(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,0,1,0,0,99,99
0,0,0,0,0,0,0,0,2,0,0,0,0,1,0,0,1,0,0,99,99
0,0,0,0,0,1,1,0,1,0,0,0,0,1,0,0,1,0,0,99,99
0,0,0,0,0,1,1,0,2,0,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,0,1,0,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,0,2,0,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,0,0,0,1,0,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,0,0,0,2,0,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,0,1,0,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,0,1,0,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,0,1,0,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,1,2,0,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,2,2,0,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,3,2,0,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,0,0,1,1,1,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,2,1,1,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,3,1,1,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,0,0,0,2,1,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,0,2,1,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,1,2,1,0,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,0,0,0,1,0,2,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,0,1,0,2,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,1,1,0,2,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,0,0,0,2,0,2,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,0,2,0,2,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,1,2,0,2,0,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,0,1,0,0,2,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,0,2,0,0,2,0,1,0,0,1,0,0,99,99
0,0,0,1,1,0,0,1,1,0,0,2,0,1,0,0,1,0,0,99,99
0,0,0,1,1,0,0,0,2,0,0,2,0,1,0,0,1,0,0,99,99
0,0,0,0,0,0,0,0,1,0,0,2,0,1,0,0,1,0,0,99,99
0,0,0,0,0,0,0,0,2,0,0,2,0,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,0,1,0,0,0,1,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,0,2,0,0,0,1,1,0,0,1,0,0,99,99
0,0,0,1,1,0,0,0,1,0,0,0,1,1,0,0,1,0,0,99,99
0,0,0,1,1,0,0,0,2,0,0,0,1,1,0,0,1,0,0,99,99
0,0,0,0,0,0,0,0,1,0,0,0,1,1,0,0,1,0,0,99,99
0,0,0,0,0,0,0,0,2,0,0,0,1,1,0,0,1,0,0,99,99
0,0,0,1,1,1,1,0,1,0,0,0,0,0,0,0,1,0,0,99,99
0,0,0,1,1,1,1,0,2,0,0,0,0,0,0,0,1,0,0,99,99
0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,1,0,0,99,99
0,0,0,1,1,0,0,0,2,0,0,0,0,0,0,0,1,0,0,99,99
0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,99,99
0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,1,0,0,99,99
0,0,0,1,1,1,1,0,1,0,0,0,0,1,1,0,1,0,0,99,99
0,0,0,1,1,1,1,0,2,0,0,0,0,1,1,0,1,0,0,99,99
0,0,0,1,1,0,0,0,1,0,0,0,0,1,1,0,1,0,0,99,99
0,0,0,1,1,0,0,0,2,0,0,0,0,1,1,0,1,0,0,99,99
0,0,0,0,0,0,0,0,1,0,0,0,0,1,1,0,1,0,0,99,99
0,0,0,0,0,0,0,0,2,0,0,0,0,1,1,0,1,0,0,99,99
0,0,0,1,1,0,0,0,1,0,0,0,0,1,0,1,1,0,0,99,99
0,0,0,1,1,1,1,0,1,0,0,0,0,1,0,1,1,0,0,99,99
0,0,0,1,1,1,1,0,1,0,0,0,0,1,0,1,1,0,0,99,99
0,0,0,1,1,0,0,0,2,0,0,0,0,1,0,1,1,0,0,99,99
0,0,0,1,1,1,1,0,2,0,0,0,0,1,0,1,1,0,0,99,99
0,0,0,1,1,1,1,1,2,0,0,0,0,1,0,1,1,0,0,99,99
0,0,0,1,1,0,0,0,2,0,0,0,0,1,0,0,0,0,0,99,99
0,0,0,1,1,1,1,0,2,0,0,0,0,1,0,0,0,0,0,99,99
0,0,0,1,1,1,1,1,2,0,0,0,0,1,0,0,0,0,0,99,99
0,0,0,1,1,0,0,0,1,0,0,0,0,1,0,0,1,1,0,99,99
0,0,0,1,1,1,1,0,1,0,0,0,0,1,0,0,1,1,0,99,99
0,0,0,1,1,1,1,1,1,0,0,0,0,1,0,0,1,1,0,99,99
0,0,0,1,1,0,0,0,2,0,0,0,0,1,0,0,1,1,0,99,99
0,0,0,1,1,1,1,0,2,0,0,0,0,1,0,0,1,1,0,99,99
0,0,0,1,1,1,1,1,2,0,0,0,0,1,0,0,1,1,0,99,99
0,0,0,1,1,1,1,0,1,0,0,0,0,1,0,0,1,0,2,99,99
0,0,0,1,1,1,1,0,2,0,0,0,0,1,0,0,1,0,2,99,99
0,0,0,1,1,0,0,1,1,0,0,0,0,1,0,1,1,0,0,0,99
0,0,0,1,1,1,1,0,1,0,0,0,0,1,0,1,1,0,0,0,99
0,0,0,1,1,0,0,0,2,0,0,0,0,1,0,1,1,0,0,0,99
0,0,0,1,1,1,1,0,2,0,0,0,0,1,0,1,1,0,0,0,99
0,0,0,1,1,0,0,0,1,0,0,0,0,1,0,1,1,0,0,7,1
0,0,0,1,1,1,1,0,1,0,0,0,0,1,0,1,1,0,0,7,1
0,0,0,1,1,0,0,0,2,0,0,0,0,1,0,1,1,0,0,7,1
0,0,0,1,1,1,1,0,2,0,0,0,0,1,0,1,1,0,0,7,1
0,0,0,1,1,0,0,0,1,0,0,0,0,1,0,1,1,0,0,7,0
0,0,0,1,1,1,1,0,1,0,0,0,0,1,0,1,1,0,0,7,0
0,0,0,1,1,0,0,0,2,0,0,0,0,1,0,1,1,0,0,7,0
0,0,0,1,1,1,1,0,2,0,0,0,0,1,0,1,1,0,0,7,0
)
RSN_PTN_CNT=`expr ${#RSN_PTN[@]} - 1`

# Sub 
# Usage
func_USAGE()
{
    echo "
 1) 加入者登録／収集／削除 の場合
    CreateDB.sh MACHINE STEP MSN IMUI TYPE PTN
               MACHINE : 検証機名.
                           CDBの場合: guk/gul/gum
                           RDBの場合: fra/frb/frf/ghg/ghi
               STEP    : 工程.
                           cre: 登録
                           all: 加入者情報(全項目)
                           mid: 加入者情報(一部)
                           del: 解除
               MSN     : 加入者番号. 10桁 or 13桁.
               IMUI    : 移動機番号. 15桁固定.
               TYPE    : 試験種別.
                           lck: ロック/ロック解除.
                           wpe: WIPE.
                           rsd: 再送
               PTN     : TYPE毎のパターン番号.
                           TYPE=lck: 1 - ${LCK_PTN_CNT}
                           TYPE=wpe: 1 - ${WPE_PTN_CNT}
                           TYPE=rsd: 1 - ${RSN_PTN_CNT}

 2) 個別設定の場合. 
    CreateDB.sh DBKIND NUMBER MNO VALUE
               DBKIND  : DB種別.
                           pdb: 加入者DB
                           tdb: 移動機DB
               NUMBER  : MSN or IMUI
               MNO     : MNO番号.
               VALUE   : 設定値.

   ・設定可能項目
      PMNO:685 ロック・ワイプ ノード番号
      PMNO:686 ロック・ワイプ FEP番号
      PMNO:687 ロック・ワイプ USP番号
      PMNO:509 LTE契約
      PMNO:670 5G契約
      PMNO:461 設定通知再送開始・成功日時(yyyymmddHHMM)

"
#   grep ^#U ${0} | sed -e 's/^#U//g'
    exit
}
#********************************************************
# Q&A:函数末尾 exit的意思？
# exit：退出脚本
# 顺便提一下，exit 0 代表正常运行程序并退出程序，
# exit 1 代表非正常运行导致退出程序
# 目的就是: 程序退出后, 用户可以 echo $? 来查看是 0 还是 1, 
# 从而达到检测程序是正常结束退出还是产生错误而退出的目的.
#********************************************************
#
# Debug
func_DEBUG()
{
    [ ${DEBUGFLAG} -eq 1 ] && echo $@
}
#********************************************************
# Q&A: && 的意思？
# 语法格式如下：command1 && command2 [&& command3 ...]
# 1.命令之间使用 && 连接，实现逻辑与的功能。
# 2.只有在 && 左边的命令返回真（命令返回值 $? == 0），&& 右边的命令才会被执行。
# 3.只要有一个命令返回假（命令返回值 $? == 1），后面的命令就不会被执行。
# 扩展，||则与&&相反
#********************************************************
#
# NSMA
func_NSMA()
{
    if [ ${1} -eq ${DEF_NSMA_SET} ]
    then
        func_CMD "### 信号規制"
        if [ ${NOW_TEST_FLAG} -eq ${DEF_CDB__FLAG} ]
        then
            # CDB
            func_CMD NSMA SKIP ALL PRC:ALL
        else
            # RDB
            func_CMD NSMA SKIP MIS  PRC:ALL
            func_CMD NSMA SKIP NMIS PRC:ALL
            func_CMD NSMA SKIP MPN  PRC:ALL
        fi

    else
        func_CMD "### 信号規制解除"
        if [ ${NOW_TEST_FLAG} -eq ${DEF_CDB__FLAG} ]
        then
            # CDB
            func_CMD NSMA SKIP CLR ALL PRC:ALL
        else
            # RDB
            func_CMD NSMA SKIP CLR MIS  PRC:ALL
            func_CMD NSMA SKIP CLR NMIS PRC:ALL
            func_CMD NSMA SKIP CLR MPN  PRC:ALL
        fi
    fi

    func_CMD nb
}
#
# Change MobilePosition
func_MPRG()
{
    local in_name=${1}
    local in_msn_=${2}
    func_DEBUG "${LINENO}: func_MPRG START"

    case "${in_name}" in
        "fra")
            func_DEBUG "${LINENO}: RDB - FRA"
            ;;
        "frb")
            func_DEBUG "${LINENO}: RDB - FRB"
            ;;
        "frf")
            func_DEBUG "${LINENO}: RDB - FRF"
            ;;
        "gh[hai]")
            func_DEBUG "${LINENO}: RDB - GHG or GHA or GHI"
            ;;
        gu[klm])
            func_CMD "### 在圏情報登録 "
            func_CMD chg_mprg IMUI:${in_imui} ASNNO:81905420540 ASNADR:172.024.128.042 CSNSIP:192.168.121.036 CSNDIA:010.001.128.133 SINADR:010.144.019.005 SINNO:81905420530 PURGE
            func_CMD chg_mprg IMUI:${in_imui} SGSNNO:81905420915 SGSNADR:123.123.123.124 PURGE
            func_CMD chg_mprg IMUI:${in_imui} MMEID:4c0410 MMPNO:00 PURGE
            func_CMD nb
            ;;
    esac

    func_DEBUG "${LINENO}: func_MPRG END"
}
#********************************************************
# Q&A: 上面函数内的语法点？
# shell函数定义的变量也是global的，其作用域从函数被调用执行变量的地方开始，到shell或结束或者显示删除为止。
# 函数定义的变量可以是local的，其作用域局限于函数内部。但是函数的参数是local的。
# ${LINENO} 是一个从1开始累加的环境变量，每开一个shell重新计数，每打印一次加一。
# case分支语句的格式如下：
# case $变量名 in
#      模式1）
#      命令序列1
#      ;;
#********************************************************
#
# Set Subscriber (Lock/UnLock)
func_REG_SUB_LOCK()
{
    local in_msn_=${1}
    local in_imui=${2}
    local set_ptn=${LCK_PTN[${3}]}
    func_DEBUG "${LINENO}: func_REG_SUB: Lock/Unlock START"

    THSC_759 ${in_imui} `echo ${set_ptn} | cut -d , -f 1`
    THSC_752 ${in_imui} `echo ${set_ptn} | cut -d , -f 2`
    THSC_763 ${in_imui} `echo ${set_ptn} | cut -d , -f 3`
    THSC_401 ${in_imui} `echo ${set_ptn} | cut -d , -f 4`
    THSC_414 ${in_imui} `echo ${set_ptn} | cut -d , -f 5`
    PHSC_750 ${in_msn_} `echo ${set_ptn} | cut -d , -f 6`
    PHSC_761 ${in_msn_} `echo ${set_ptn} | cut -d , -f 7`
    PHSC_363 ${in_msn_} `echo ${set_ptn} | cut -d , -f 8`
    THSC_325 ${in_imui} `echo ${set_ptn} | cut -d , -f 9`
    THSC_309 ${in_imui} `echo ${set_ptn} | cut -d , -f 10`
    THSC_321 ${in_imui} `echo ${set_ptn} | cut -d , -f 11`
    PHSC_573 ${in_msn_} `echo ${set_ptn} | cut -d , -f 12`

    func_DEBUG "${LINENO}: func_REG_SUB: Lock/Unlock END"
}
#
# Set Subscriber (WIPE)
func_REG_SUB_WIPE()
{
    local in_msn_=${1}
    local in_imui=${2}
    local set_ptn=${WPE_PTN[${3}]}
    func_DEBUG "${LINENO}: func_REG_SUB: WIPE START"

    THSC_759 ${in_imui} `echo ${set_ptn} | cut -d , -f 1`
    THSC_752 ${in_imui} `echo ${set_ptn} | cut -d , -f 2`
    THSC_763 ${in_imui} `echo ${set_ptn} | cut -d , -f 3`
    THSC_401 ${in_imui} `echo ${set_ptn} | cut -d , -f 4`
    THSC_414 ${in_imui} `echo ${set_ptn} | cut -d , -f 5`
    PHSC_750 ${in_msn_} `echo ${set_ptn} | cut -d , -f 6`
    PHSC_761 ${in_msn_} `echo ${set_ptn} | cut -d , -f 7`
    PHSC_363 ${in_msn_} `echo ${set_ptn} | cut -d , -f 8`
    PHSC_460 ${in_msn_} `echo ${set_ptn} | cut -d , -f 9`
    PHSC_301 ${in_msn_} `echo ${set_ptn} | cut -d , -f 10`
    THSC_325 ${in_imui} `echo ${set_ptn} | cut -d , -f 11`
    THSC_333 ${in_imui} `echo ${set_ptn} | cut -d , -f 12`
    THSC_308 ${in_imui} `echo ${set_ptn} | cut -d , -f 13`
    THSC_310 ${in_imui} `echo ${set_ptn} | cut -d , -f 14`
    THSC_322 ${in_imui} `echo ${set_ptn} | cut -d , -f 15`
    PHSC_573 ${in_msn_} `echo ${set_ptn} | cut -d , -f 16`

    func_DEBUG "${LINENO}: func_REG_SUB: WIPE END"
}
#
# Set Subscriber (ReSend)
func_REG_SUB_ReSEND()
{
    local in_msn_=${1}
    local in_imui=${2}
    local set_ptn=${RSN_PTN[${3}]}
    func_DEBUG "${LINENO}: func_REG_SUB: ReSEND START"

    THSC_759 ${in_imui} `echo ${set_ptn} | cut -d , -f 1`
    THSC_752 ${in_imui} `echo ${set_ptn} | cut -d , -f 2`
    THSC_763 ${in_imui} `echo ${set_ptn} | cut -d , -f 3`
    THSC_401 ${in_imui} `echo ${set_ptn} | cut -d , -f 4`
    THSC_414 ${in_imui} `echo ${set_ptn} | cut -d , -f 5`
    PHSC_750 ${in_msn_} `echo ${set_ptn} | cut -d , -f 6`
    PHSC_761 ${in_msn_} `echo ${set_ptn} | cut -d , -f 7`
    PHSC_363 ${in_msn_} `echo ${set_ptn} | cut -d , -f 8`
    PHSC_460 ${in_msn_} `echo ${set_ptn} | cut -d , -f 9`
    PHSC_435 ${in_msn_} `echo ${set_ptn} | cut -d , -f 10`
    PHSC_436 ${in_msn_} `echo ${set_ptn} | cut -d , -f 11`
    PHSC_301 ${in_msn_} `echo ${set_ptn} | cut -d , -f 12`
    THSC_325 ${in_imui} `echo ${set_ptn} | cut -d , -f 13`
    THSC_308 ${in_imui} `echo ${set_ptn} | cut -d , -f 14`
    THSC_321 ${in_imui} `echo ${set_ptn} | cut -d , -f 15`
#=============================================================
#   PHSC_461 ${in_imui} `echo ${set_ptn} | cut -d , -f 16`
#   ==> 設定通知再送開始・成功日時 は、個別設定を行う.
#       CreateDB.sh pdb DDDDDDDDDD 461 yyyymmddHHMM
#=============================================================
    PHSC_476 ${in_msn_} `echo ${set_ptn} | cut -d , -f 17`
    smdo_TAC            `echo ${set_ptn} | cut -d , -f 18`
    PHSC_573 ${in_msn_} `echo ${set_ptn} | cut -d , -f 19`
    PHSC_422 ${in_msn_} `echo ${set_ptn} | cut -d , -f 20`
#=============================================================
#   Sdm-IF 
#   ==> FSCP マルチ構成(FSCP×2台)向けの試験の場合使用   
    PHSC_496          ${in_msn_} `echo ${set_ptn} | cut -d , -f 21`
#=============================================================

    func_DEBUG "${LINENO}: func_REG_SUB: ReSEND END"
}
#
# Check TYPE + PTN
func_CHK_PATTERN()
{
    local in_type=${1}
    local in_ptn_=${2}
    local ptn_max=0
    case "${in_type}" in
        "lck")     ptn_max=${LCK_PTN_CNT}  ;;
        "wpe")     ptn_max=${WPE_PTN_CNT}  ;;
        "rsd")     ptn_max=${RSN_PTN_CNT}  ;;
    esac
    if [ ${in_ptn_} -gt ${ptn_max} ]; then
        echo; echo "[Error] 範囲超え(TYPE=${in_type} 範囲=1～${ptn_max} 指定値=${in_ptn_})."
        func_USAGE; exit
    fi
}
#
# Set Subscriber( SSFS + PHSC + THSC + chg_mprg )
func_REG_SUB()
{
    local in_name=${1}
    local in_msn_=${2}
    local in_imui=${3}
    local in_type=${4}
    local in_ptn_=${5}
    func_DEBUG "${LINENO}: func_REG_SUB: MAIN START"

    # 機能とパターン を判定
    func_CHK_PATTERN ${in_type} ${in_ptn_}

    func_NSMA ${DEF_NSMA_SET}

    SSFS_REG ${in_msn_} ${in_imui}
    PHSC_509 ${in_msn_} 1
#    PHSC_670 ${in_msn_} 1
#	 PHSC_685 ${in_msn_} 0
	PHSC_686 ${in_msn_} 1
	PHSC_687 ${in_msn_} 2
    THSC_366 ${in_imui}
    func_MPRG ${in_name} ${in_msn_}

    case "${in_type}" in
        "lck")     func_REG_SUB_LOCK   ${in_msn_} ${in_imui} ${in_ptn_}     ;;
        "wpe")     func_REG_SUB_WIPE   ${in_msn_} ${in_imui} ${in_ptn_}     ;;
        "rsd")     func_REG_SUB_ReSEND ${in_msn_} ${in_imui} ${in_ptn_}     ;;
    esac
    func_NSMA ${DEF_NSMA_CLR}

    func_DEBUG "${LINENO}: func_REG_SUB: MAIN END"
}
#
# Get Subscriber(All)
func_GET_SUB_ALL()
{
    local in_msn_=${1}
    local in_imui=${2}
    func_DEBUG "${LINENO}: func_GET_SUB_ALL START"

    func_CMD "### 加入者情報収集"
    func_CMD view_psdt ALL MSN:${in_msn_}
    func_CMD view_ftsr MSN:${in_msn_}
    func_CMD nb
    func_CMD PHSC CL MSN:${in_msn_}
    func_CMD THSC CL MODE:IMT IMUI:${in_imui}
    func_CMD nb

    func_DEBUG "${LINENO}: func_GET_SUB_ALL END"
}
# Get Subscriber
func_GET_SUB_MID()
{
    local in_msn_=${1}
    local in_imui=${2}
    func_DEBUG "${LINENO}: func_GET_SUB_MID START"

    func_CMD "### 加入者情報収集"
    #func_CMD PHSC CL MSN:${in_msn_} MNO:0909 MNO:0309 MNO:0464 MNO:0573 MNO:685 MNO:686 MNO:687
    #2021.10.21 収集項目追加
    func_CMD PHSC CL MSN:${in_msn_} MNO:0909 MNO:0309 MNO:476 MNO:0464 MNO:685 MNO:686 MNO:687 MNO:761 MNO:0460 MNO:0461 MNO:0573
    func_CMD nb

    func_CMD "### 移動機情報収集"
    #func_CMD THSC CL MODE:IMT IMUI:${in_imui} MNO:303 MNO:301 
    #2021.10.21 収集項目追加
    func_CMD THSC CL MODE:IMT IMUI:${in_imui} MNO:303 MNO:301 MNO:366 
    func_CMD nb

    func_DEBUG "${LINENO}: func_GET_SUB_MID END"
}
#
# Clear Subscriber
func_CCL_SUB()
{
    local in_msn_=${1}
    func_DEBUG "${LINENO}: func_CCL_SUB START"
    func_CMD "### 加入者解除"
    func_CMD SSFS CCL MSN:${in_msn_} IMTCT
    func_CMD nb
    func_DEBUG "${LINENO}: func_CCL_SUB END"
}
#
# 個別 PHSC 設定
func_PHSC_SET()
{
    local in_msn=${1}
    local in_mno=${2}
    local in_val=${3}

    case ${in_mno} in
        461)     PHSC_461 ${in_msn} ${in_val}          ;;
        509)     PHSC_509 ${in_msn} ${in_val}          ;;
        670)     PHSC_670 ${in_msn} ${in_val}          ;;
        685)     PHSC_685 ${in_msn} ${in_val}          ;;
        686)     PHSC_686 ${in_msn} ${in_val}          ;;
        687)     PHSC_687 ${in_msn} ${in_val}          ;;
    esac
}
#
# 個別 THSC 設定
func_THSC_SET()
{
    local in_imui=${1}
    local in_mno_=${2}
    local in_val_=${3}

    case ${in_mno} in
    esac
}


#********************************************************
#
# ＭＡＩＮ  
#
#********************************************************
#--------------------------------------------------------
# Check Parameter
#--------------------------------------------------------
case ${1} in
#{
    [pt]db)
        if [ "${1}" == "pdb" ]; then func_PHSC_SET ${2} ${3} ${4}
                                else func_THSC_SET ${2} ${3} ${4}
        fi
        exit
        ;;
#}
esac

case ${2} in
#{
    "cre")
        func_DEBUG "${LINENO}: Check Para(Create)"
        [ ${INPARA_CNT} -ne ${CREPARA_MAX} ] && func_USAGE 
        [ "${5}" != "lck" -a "${5}" != "wpe" -a "${5}" != "rsd" ] && func_USAGE
        _FSCP_NM_=${1}
        _STEP____=${DEF_STEP_CRE}
        _MSN_____=${3}
        _IMUI____=${4}
        _TYPE____=${5}
        _PATTERN_=${6}
        ;;
    "all")
        func_DEBUG "${LINENO}: Check Para(Before)"
        [ ${INPARA_CNT} -ne ${BEFPARA_MAX} ] && func_USAGE 
        _FSCP_NM_=${1}
        _STEP____=${DEF_STEP_BEF}
        _MSN_____=${3}
        _IMUI____=${4}
        ;;
    "mid")
        func_DEBUG "${LINENO}: Check Para(middle)"
        [ ${INPARA_CNT} -ne ${MIDPARA_MAX} ] && func_USAGE 
        _FSCP_NM_=${1}
        _STEP____=${DEF_STEP_MID}
        _MSN_____=${3}
        _IMUI____=${4}
        ;;
    "del")
        func_DEBUG "${LINENO}: Check Para(after )"
        [ ${INPARA_CNT} -ne ${AFTPARA_MAX} ] && func_USAGE 
        _FSCP_NM_=${1}
        _STEP____=${DEF_STEP_AFT}
        _MSN_____=${3}
        ;;
    *)
        func_USAGE ;;
#}
esac

#--------------------------------------------------------
# Check Machine Name
#--------------------------------------------------------
case ${_FSCP_NM_} in
    "fr[abf]")    NOW_TEST_FLAG=${DEF_RDB__FLAG}         ;;
    "gh[gai]")    NOW_TEST_FLAG=${DEF_RDB__FLAG}         ;;
esac


func_DEBUG "${LINENO}: STEP     = ${_STEP____}"
func_DEBUG "${LINENO}: MSN      = ${_MSN_____}"
func_DEBUG "${LINENO}: IMUI     = ${_IMUI____}"


#--------------------------------------------------------
# Judge STEP
#--------------------------------------------------------
  if [ ${_STEP____} -eq ${DEF_STEP_CRE} ]
then
    func_DEBUG "${LINENO}: ######################################################"
    func_DEBUG "${LINENO}: # Before : Create Subscriber"
    func_DEBUG "${LINENO}: ######################################################"
    # SSFS REG
    # PHSC MNO:0509
    # THSC MNO:366
    # chg_mprg
    func_REG_SUB ${_FSCP_NM_} ${_MSN_____} ${_IMUI____} ${_TYPE____} ${_PATTERN_}

    # PHSC MNO:0670
    # PHSC MNO:0750

elif [ ${_STEP____} -eq ${DEF_STEP_BEF} ]
then
    func_DEBUG "${LINENO}: ######################################################"
    func_DEBUG "${LINENO}: # Before : Get Subscriber"
    func_DEBUG "${LINENO}: ######################################################"
    func_GET_SUB_ALL ${_MSN_____} ${_IMUI____}

elif [ ${_STEP____} -eq ${DEF_STEP_MID} ]
then
    func_DEBUG "${LINENO}: ######################################################"
    func_DEBUG "${LINENO}: # Middle : Get Subscriber"
    func_DEBUG "${LINENO}: ######################################################"
    func_GET_SUB_MID ${_MSN_____} ${_IMUI____}

else
    func_DEBUG "${LINENO}: ######################################################"
    func_DEBUG "${LINENO}: # After  : Get Subscriber & Clear Subscriber"
    func_DEBUG "${LINENO}: ######################################################"
    func_NSMA ${DEF_NSMA_SET}
    func_CCL_SUB ${_MSN_____}
    func_NSMA ${DEF_NSMA_CLR}

fi

```

## CreateDB_FUNC.sh

```shell
export DEBUGFLAG=0

THSC_763_HST=21B_2020_101_9_Gsc.NTC.com
THSC_763_PNO=9999
THSC_763_URL=Namf_xxxx/v1/yyyy
THSC_763_VAL=https://${THSC_763_HST}:${THSC_763_PNO}/${THSC_763_URL}

THSC_366_VAL=35a238aaaaaaaa2a
PHSC_476_VAL=${THSC_366_VAL:0:14}
_dmy=${THSC_366_VAL:0:8}
SMDO_TAC_VAL=${_dmy//a/0}
#
FSCP2nd_IMUI=441113433039121
PHSC_496_VAL=${FSCP2nd_IMUI//0/a}
#********************************************************
# Q&A:shell的字符串的操作？
# 从start开始，截取长度为length的字符串
# 格式：${str:start:length}
# 用TEST替换字符串中所有的abc
# echo ${str//abc/TEST}
#********************************************************


# Excute Command
func_CMD()
{
    if [ "${1:0:1}" == "*" -o "${1:0:1}" == "#" ]
    then
        # コメント
        echo $@
#********************************************************
# Q&A:
# 针对 func_CMD "### 加入者解除" 的情况
# ${1:0:1}就是作为参数的字符串$1的被截取的第一个字符
# $@ 全部位置参数（分别）
# -o 逻辑判断 或
#********************************************************        
    else
        if [ "${1}" == "nb" ]
        then
            # 改行
            echo
        else
            echo "> $@"
            if [ "${1}" == "PHSC" -o "${1}" == "THSC" ]
            then
                [ ${DEBUGFLAG} -eq 0 ] && ssh usp01 /SYSTEM/LM/apl/virtual/cmd/bin/$@
            else
                [ ${DEBUGFLAG} -eq 0 ] && $@
            fi
        fi
    fi
}

#*************************************************************
# 
# SSFS
# 
#*************************************************************
SSFS_REG()
{
func_CMD "### 加入者登録"
func_CMD SSFS REG MSN:${1} IMUI:${2} IMKEY:00112233445566778899AABBCCDDEEFF NTID:020 IMTCT TELID0 BOTH URSN BES USP64 DSP64 CLIP:R CRCNO IRMS:R ROSR PRSR PPWN:1234 RMKEY:1234567890ABCDEF1234567890ABCDEF MID:004668124546054 UIM:DNEU20000000232 IMP1 IMTCH:R IMTIMD:R IMPIDN:R SMSMO:R WCS:R NULAT INCT IMSN:${1} IIMUI:${2} INTID:020 IIMP:1 IIRM:R INATOPE:001
func_CMD nb
}



#*************************************************************
# 
# PHSC
# 
#*************************************************************

# P2: 0: MSC+SGSN(bothMSCAndSGSN)
#     1: MSC(onlyMSC)
#     2: SGSN(onlySGSN)
PHSC_301()
{
  func_CMD "### ネットワークアクセス方法(Network Access Mode) 設定"
    if [ ${2} -eq 1 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:301=1
  elif [ ${2} -eq 2 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:301=2
                       else func_CMD PHSC SE MODE:IMT MSN:${1} MNO:301=0
  fi
  func_CMD nb
}

# P2: 0: 未契約加入者
#     1: 基本契約者番号
#     2: 付加番号1
#     3: 付加番号2
#     4: ハイパーマルチ基本契約者番号
#     5: ハイパーマルチ付加番号
#     6: 新2in1A番号
#     7: 新2in1B番号
#     8: WS3 Aナンバー
#     9: WS3 Fナンバー
#    99: 設定無し  
PHSC_422(){
  [ ${2} -eq 99 ] && func_CMD "### ビジネスナンバー加入者種別 未設定" && exit
  func_CMD "### ビジネスナンバー加入者種別 設定"
    if [ ${2} -eq 1 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:422=1
  elif [ ${2} -eq 2 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:422=2
  elif [ ${2} -eq 3 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:422=3
  elif [ ${2} -eq 4 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:422=4
  elif [ ${2} -eq 5 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:422=5
  elif [ ${2} -eq 6 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:422=6
  elif [ ${2} -eq 7 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:422=7
  elif [ ${2} -eq 8 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:422=8
  elif [ ${2} -eq 9 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:422=9
                       else func_CMD PHSC SE MODE:IMT MSN:${1} MNO:422=0
  fi
  func_CMD nb
}

# P2: 0: 未再送 
#     1: 再送中 
#     2: 端末ロック再送中 
#     3: 初期設定再送中 
PHSC_460()
{
  func_CMD "### 設定通知再送表示 設定 "
    if [ ${2} -eq 1 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:460=1
  elif [ ${2} -eq 2 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:460=2
  elif [ ${2} -eq 3 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:460=3
                       else func_CMD PHSC SE MODE:IMT MSN:${1} MNO:509=0
  fi
  func_CMD nb
}

# P2: 0: 開通(未登録)
#     1: 未開通(登録)
PHSC_435()
{
  func_CMD "### 自動開通表示 設定"
    if [ ${2} -eq 1 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:435=1
                       else func_CMD PHSC SE MODE:IMT MSN:${1} MNO:435=0
  fi
  func_CMD nb
}

# P2: 0: 非許容 (Default)
#     1: 許容(契約者)
#     2: モジュール
#     3: 予備
PHSC_436()
{
  func_CMD "### FOMAスイッチホン契約種別 設定" 
    if [ ${2} -eq 1 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:436=1
  elif [ ${2} -eq 2 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:436=2
  elif [ ${2} -eq 3 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:436=3
                       else func_CMD PHSC SE MODE:IMT MSN:${1} MNO:436=0
  fi
  func_CMD nb
}

# P1: 0: 不一致 : THSC MNO:366 と異なる値を設定 
#     1: 一致   : THSC MNO:366 と等しい値を設定 
PHSC_476()
{
  func_CMD "### 端末ロック対象IMEI 設定"
  if [ ${2} -eq 1 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:476=${PHSC_476_VAL}
                     else func_CMD PHSC SE MODE:IMT MSN:${1} MNO:476=35a23899999999
  fi
  func_CMD nb
}

# P2: 0: 未収容    => 0000000000000000
#     1: 収容      => $PHSC_496_VAL
#    99:           => 未設定  
PHSC_496()
{
  [ ${2} -eq 99 ] && func_CMD "### 2in1異名義対応用IMUI 未設定" && exit
  func_CMD "### 2in1異名義対応用IMUI 設定"
  if [ ${2} -eq 1 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:496=${PHSC_496_VAL}
                     else func_CMD PHSC SE MODE:IMT MSN:${1} MNO:496=0000000000000000
  fi
  func_CMD nb
}

# P2: 0: 未契約
#     1: 契約
PHSC_509()
{
  func_CMD "### LTE契約 設定"
    if [ ${2} -eq 1 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:509=1
                       else func_CMD PHSC SE MODE:IMT MSN:${1} MNO:509=0
  fi
  func_CMD nb
}
# P2: 0: 未契約
#     1: 契約
PHSC_670()
{
  func_CMD "### 5G契約 設定"
  if [ ${2} -eq 1 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:670=1
                     else func_CMD PHSC SE MODE:IMT MSN:${1} MNO:670=0
  fi
  func_CMD nb
}
# P2: 0: 未契約
#     1: 契約
PHSC_750()
{
  func_CMD "### 5GC契約 設定"
  if [ ${2} -eq 1 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:750=1
                     else func_CMD PHSC SE MODE:IMT MSN:${1} MNO:750=0
  fi
  func_CMD nb
}
# 0: 活性
# 1: 非活性
PHSC_761()
{
  func_CMD "### 5GC活性状態 設定"
  if [ ${2} -eq 1 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:761=1
                     else func_CMD PHSC SE MODE:IMT MSN:${1} MNO:761=0
  fi
  func_CMD nb
}
# 0: 0000000_0_0_0_0_0:非ODB
# 1: 0000001_0_0_0_0_0:通停（発信）
# 2: 0000010_0_0_0_0_0:通停（着信）
# 3: 0010000_0_0_0_0_0:一時撤去
PHSC_363()
{
  func_CMD "### ドコモODB 設定" 
    if [ ${2} -eq 1 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:363=0000001_0_0_0_0_0
  elif [ ${2} -eq 2 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:363=0000010_0_0_0_0_0
  elif [ ${2} -eq 3 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:363=0010000_0_0_0_0_0
                       else func_CMD PHSC SE MODE:IMT MSN:${1} MNO:363=0000000_0_0_0_0_0
  fi
  func_CMD nb
}
# 0: 0_0:変換解除
# 1: 1_0:おまかせロック
# 2: 2_0:ケータイお探し
PHSC_573()
{
  func_CMD "### APN変換フラグ(フラグ_制御情報) 設定"
    if [ ${2} -eq 1 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:573=1_0
  elif [ ${2} -eq 2 ]; then func_CMD PHSC SE MODE:IMT MSN:${1} MNO:573=2_0
                       else func_CMD PHSC SE MODE:IMT MSN:${1} MNO:573=0_0
  fi
  func_CMD nb
}

# P2: そのまま設定  
PHSC_685()
{
  func_CMD "### ロック・ワイプ ノード番号 設定"
  func_CMD PHSC SE MODE:IMT MSN:${1} MNO:685=${2}
  func_CMD nb
}

# P2: そのまま設定  
PHSC_686()
{
  func_CMD "### ロック・ワイプ FEP番号 設定"
  func_CMD PHSC SE MODE:IMT MSN:${1} MNO:686=${2}
  func_CMD nb
}

# P2: そのまま設定  
PHSC_687()
{
  func_CMD "### ロック・ワイプ USP番号 設定"
  func_CMD PHSC SE MODE:IMT MSN:${1} MNO:687=${2}
  func_CMD nb
}


#*************************************************************
# 
# THSC
# 
#*************************************************************
# P2: 0: VLRナンバー(VLR number) 無し -> クリア  
#     1: VLRナンバー(VLR number) 有り -> 何もしない   
THSC_308()
{
  func_CMD "### VLR number 設定" 
    if [ ${2} -eq 0 ]; then func_CMD THSC SE MODE:IMT IMUI:${1} MNO:308=0000000000000000
                       else func_CMD "### 在圏情報(chg_mprg) 依存"
  fi
  func_CMD nb
}

# P2: 0: MSCナンバー無し 
#     1: MSCナンバー有り : 何もしない 
THSC_309()
{
  func_CMD "### MSC number 設定"
    if [ ${2} -eq 0 ]; then func_CMD THSC SE MODE:IMT IMUI:${1} MNO:309=0000000000000000
                       else func_CMD "### 在圏情報(chg_mprg) 依存"
  fi
  func_CMD nb
}

# P2: 0: SGSN number 無し -> クリア
#     1: SGSN number 有り -> 何もしない 
THSC_310()
{
  func_CMD "### SGSN number 設定"
    if [ ${2} -eq 0 ]; then func_CMD THSC SE MODE:IMT IMUI:${1} MNO:310=0000000000000000
                       else func_CMD "### 在圏情報(chg_mprg) 依存"
  fi
  func_CMD nb
}
# P2: 0: パージ無し
#     1: パージ有り
THSC_321()
{
  func_CMD "### 移動機パージフラグ 設定"
    if [ ${2} -eq 1 ]; then func_CMD THSC SE MODE:IMT IMUI:${1} MNO:321=1
                       else func_CMD THSC SE MODE:IMT IMUI:${1} MNO:321=0
  fi
  func_CMD nb
}

# P2: 0: パージ無し(MS not purged for GPRS)
#     1: パージ有り(MS purged for GPRS)
THSC_322()
{
  func_CMD "### GPRS移動機パージフラグ(MS purged for GPRS flag) 設定"
    if [ ${2} -eq 1 ]; then func_CMD THSC SE MODE:IMT IMUI:${1} MNO:322=1
                       else func_CMD THSC SE MODE:IMT IMUI:${1} MNO:322=0
  fi
  func_CMD nb
}

# P2: 0: ドコモ網在圏
#     1: ローミング中
THSC_325()
{
  func_CMD "### ローミング中表示 設定"
  if [ ${2} -eq 1 ]; then func_CMD THSC SE MODE:IMT IMUI:${1} MNO:325=1
                     else func_CMD THSC SE MODE:IMT IMUI:${1} MNO:325=0
  fi
  func_CMD nb
}
# P2: 0: 非ローミング中
#     1: ローミング中
THSC_333()
{
  func_CMD "### パケットローミング中フラグ 設定"
  if [ ${2} -eq 1 ]; then func_CMD THSC SE MODE:IMT IMUI:${1} MNO:333=1
                     else func_CMD THSC SE MODE:IMT IMUI:${1} MNO:333=0
  fi
  func_CMD nb
}

# IMEISV 固定値設定
THSC_366()
{
  func_CMD "### IMEISV 設定"
  func_CMD THSC SE MODE:IMT IMUI:${1} MNO:366=${THSC_366_VAL}
  func_CMD nb
}

# 0: ALL 0 ( chg_mprg 依存 )
# 1: 0 以外
#   [2021.10.21] ALL0とは「0」ではないよう。
THSC_401()
{
  func_CMD "### MME Name 設定"
  if [ ${2} -eq 1 ]; then func_CMD "### 在圏情報(chg_mprg) 依存"
                     else func_CMD "### DEFAULTのままで設定なし"
  fi
  func_CMD nb
}

# 0: ALL 0 (何もしない)
# 1: 0 以外 (固定 819a542aaaaaaa11 を設定)
#   [2021.10.21] ALL0とは「0」ではないよう。
THSC_414()
{
  func_CMD "### MME-Number-for-MT-SMS 設定"
  if [ ${2} -eq 1 ]; then func_CMD THSC SE MODE:IMT IMUI:${1} MNO:414=819a542aaaaaaa11
#                    else func_CMD THSC SE MODE:IMT IMUI:${1} MNO:414=0000000000000000
                     else func_CMD "### DEFAULTのままで設定なし"
  fi
  func_CMD nb
}

# 0: パージ無し 
# 1: パージ有り 
THSC_752()
{
  func_CMD "### 5GC移動機パージフラグ 設定"
  if [ ${2} -eq 1 ]; then func_CMD THSC SE MODE:IMT IMUI:${1} MNO:752=1
                     else func_CMD THSC SE MODE:IMT IMUI:${1} MNO:752=0
  fi
  func_CMD nb
}
# 0: ALL 0
# 1: 0 以外 
#   [2021.10.18] ALL0とは「0」ではないよう。
THSC_759()
{
  func_CMD "### SMSFアドレス 設定"
  if [ ${2} -eq 1 ]; then func_CMD THSC SE MODE:IMT IMUI:${1} MNO:759=smsf.3gppnetwork.org
#                    else func_CMD THSC SE MODE:IMT IMUI:${1} MNO:759=00000000000000000000
                     else func_CMD "### DEFAULTのままで設定なし"
  fi
  func_CMD nb
}

# P2: 0: ALL 0
#     1: 0 以外 -> 固定値設定. 
#   [2021.10.18] ALL0とは「0」ではないよう。
THSC_763()
{
  func_CMD "### DeregCallBackURI(AMF-UECMプロシージャ用) 設定 "
  if [ ${2} -eq 1 ]; then func_CMD THSC SE MODE:IMT IMUI:${1} MNO:763=${THSC_763_VAL}
#                    else func_CMD THSC SE MODE:IMT IMUI:${1} MNO:763=000000000000000000000000000000000000000
                     else func_CMD "### DEFAULTのままで設定なし"
  fi
  func_CMD nb
}




# P1: 0: ロック対応端末   : 0000000000000880 
#     1: ロック非対応端末 : 0000000000000C80
smdo_TAC()
{
  func_CMD "### TAC制御情報 設定"
  if [ ${1} -eq 1 ]; then func_CMD reg_smdo MT:0000000000000C80 TAC:${SMDO_TAC_VAL}
                     else func_CMD reg_smdo MT:0000000000000880 TAC:${SMDO_TAC_VAL}
  fi
  func_CMD nb
}

```

