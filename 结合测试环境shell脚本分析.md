## CDB环境shell脚本分析

## CreateDB.sh

核心是shell中数组作为database存储容器的应用。

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
#********************************************************
# Q&A: `echo ${set_ptn} | cut -d , -f 1`的意思？
# cut用来从标准输入或文本文件中剪切列或域。
# 一般格式为：cut [options] file1 file2
# -d  指定与空格和t a b键不同的域分隔符。
# -f field  指定剪切域数。
#********************************************************
#
#
# Check TYPE + PTN
func_CHK_PATTERN()
{
    local in_type=${1}
    local in_ptn_=${2}
    local ptn_max=0
    case "${in_type}" in
        "lck")     ptn_max=${LCK_PTN_CNT}  ;;
    esac
    if [ ${in_ptn_} -gt ${ptn_max} ]; then
        echo; echo "[Error] 範囲超え(TYPE=${in_type} 範囲=1～${ptn_max} 指定値=${in_ptn_})."
        func_USAGE; exit
    fi
}
#
#********************************************************
# Q&A: shell脚本函数如何传参？
# 上例$1, $2就是两个参数值，所以要与脚本主体的$1,$2作区分。
# 脚本主体入参实质就是程序入参，跟C程序名后添参数一样。
#********************************************************
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
	PHSC_686 ${in_msn_} 1
	PHSC_687 ${in_msn_} 2
    THSC_366 ${in_imui}
    func_MPRG ${in_name} ${in_msn_}

    case "${in_type}" in
        "lck")     func_REG_SUB_LOCK   ${in_msn_} ${in_imui} ${in_ptn_}     ;;
    esac
    func_NSMA ${DEF_NSMA_CLR}

    func_DEBUG "${LINENO}: func_REG_SUB: MAIN END"
}
#
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

#--------------------------------------------------------
#
# ＭＡＩＮ  
#
#--------------------------------------------------------
# Check Parameter
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
#********************************************************
# Q&A: Shell逻辑运算总结？
# 见附录1
#********************************************************        
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

# Check Machine Name
case ${_FSCP_NM_} in
    "fr[abf]")    NOW_TEST_FLAG=${DEF_RDB__FLAG}         ;;
    "gh[gai]")    NOW_TEST_FLAG=${DEF_RDB__FLAG}         ;;
esac


func_DEBUG "${LINENO}: STEP     = ${_STEP____}"
func_DEBUG "${LINENO}: MSN      = ${_MSN_____}"
func_DEBUG "${LINENO}: IMUI     = ${_IMUI____}"


# Judge STEP
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

# SSFS
SSFS_REG()
{
func_CMD "### 加入者登録"
func_CMD SSFS REG MSN:${1} IMUI:${2} IMKEY:00112233445566778899AABBCCDDEEFF NTID:020 IMTCT TELID0 BOTH URSN BES USP64 DSP64 CLIP:R CRCNO IRMS:R ROSR PRSR PPWN:1234 RMKEY:1234567890ABCDEF1234567890ABCDEF MID:004668124546054 UIM:DNEU20000000232 IMP1 IMTCH:R IMTIMD:R IMPIDN:R SMSMO:R WCS:R NULAT INCT IMSN:${1} IIMUI:${2} INTID:020 IIMP:1 IIRM:R INATOPE:001
func_CMD nb
}

# PHSC

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

# ...........#
# ...........#
# ...........#

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

# THSC
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

# ...........#
# ...........#
# ...........#

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

## GetGscCoreUSP2.sh

下例脚本最主要的思想，就是将旧log拷贝一份，然后一定时间后新的log与之比较，就能得出这段时间新增的log，最后转运压缩取得。

```shell
# Debug Flag
#   0: No Debug + Excute Command
#   1:    Debug + Excute Command
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
DEBUGFLAG=0
func_DEBUG()
{
    [ ${DEBUGFLAG} -eq 1 ] && echo $@
}

# Save Path
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Fbb=Gsc
#SAVEPATH=/tmp/${Fbb}
SAVEPATH=/tmp/${Fbb}/TOOL

# Tool
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
TOOLNAME=`basename $0`
TGZFILE=GscCore.tgz

# Data
#^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# USP Counter
USPMAX=1
# USP NAME
USPHOST=(usp00
usp01
usp02
usp03
usp04
usp05
)

#-----------------------------------
# Item
#-----------------------------------
#     Msglog
#     Core -+- FS   -+-  565: 565_Itc
#           |        +- 1023: 1023_Itc
#           |        +- 1047: 1047_Itc
#           +- USP0 -+- 1024: 1024_Gsc
#                    +-  550: 550_Gsc
#                    +-  538: 538_Nsm
#-----------------------------------
# Get FS Item(FMT: PROCID,FILENAME)
FSITEM=(565,Itc000
1023,Itc001
1047,Itc002
)
# Get USP Item(FMT: PROCID,FILENAME)
USPITEM=(565,Itc000
1047,Itc002
538,Nsm000
550,Gsc
1024,Gsc100
)

# Create Diff_File
func_Diff()
{
    local old_=${1}
    local new_=${2}
    local diff=${3}
    func_DEBUG "${LINENO}: func_Diff Old:${old_} New:${new_} DIff:${diff}"
    diff --unchanged-group-format='' --new-group-format='%>' ${old_} ${new_} >> ${diff}
}


# Get FSCP Name & Set USP Counter
FSCPNAME=`grep -A 1 "IPSCP;" /ipscp/odm/GEN/uniIPSCP | tail -1 | cut -d = -f2 | cut -d \; -f1`
case ${FSCPNAME} in
    R[ABF])     USPMAX=6            ;;
    GU[KLM])    USPMAX=2            ;;
    GH[HAI])    USPMAX=2            ;;
    J)          USPMAX=2            ;;
esac
func_DEBUG "${LINENO}: USP Counter: $USPMAX"
func_DEBUG "${LINENO}: P1 = ${1}"


if [ "${1}" == "bef" ]
then
#{
    func_DEBUG "${LINENO}: Delete Old File/Directory"
    rm -rf ${SAVEPATH}/Msglog*
    rm -rf ${SAVEPATH}/Core*
    rm -rf ${SAVEPATH}/${TGZFILE}

    func_DEBUG "${LINENO}: Copy Msglog"
    befmsg=msg`date +%y%m%d`.log
    cp -p /SYSTEM/LOG/msglog/${befmsg} ${SAVEPATH}/${befmsg}

    func_DEBUG "${LINENO}: Copy FS CORE"
    mkdir -p ${SAVEPATH}/Core/FS
    for item in "${FSITEM[@]}"
    do
        func_DEBUG "${LINENO}: Get Item = ${item}"
        pth=`echo ${item} | sed -e 's/,/\//g'`
        pid=`echo ${item} | cut -d , -f1`
        fnm=`echo ${item} | cut -d , -f2`
        svf=$( printf "%04d" $pid )_${fnm}
    
        # If *.old, Copy
        [ -f /SYSTEM/CORE/core/${pth}.old ] && cp -p /SYSTEM/CORE/core/${pth}.old ${SAVEPATH}/Core/FS/${svf}.old
        cp -p /SYSTEM/CORE/core/${pth}.log ${SAVEPATH}/Core/FS/${svf}.log
    done

    func_DEBUG "${LINENO}: Copy USP CORE"
    for uno in `seq 0 $(( ${USPMAX} - 1 ))`
    do
        uspnm=$( printf "USP%02d" $uno )
        mkdir -p ${SAVEPATH}/Core/${uspnm}
        func_DEBUG "${LINENO}: Get ${uspnm}"
        for item in "${USPITEM[@]}"
        do
            func_DEBUG "${LINENO}: Get Item = ${item}"
            pth=`echo ${item} | sed -e 's/,/\//g'`
            pid=`echo ${item} | cut -d , -f1`
            fnm=`echo ${item} | cut -d , -f2`
            svf=$( printf "%04d" $pid )_${fnm}
 
            # If *.old, Copy
            scp -p ${uspnm}:/SYSTEM/CORE/core/${pth}.old ${SAVEPATH}/Core/${uspnm}/${svf}.old_bef 1>&/dev/null
            scp -p ${uspnm}:/SYSTEM/CORE/core/${pth}.log ${SAVEPATH}/Core/${uspnm}/${svf}.log_bef
        done
    done

    # view
    find ${SAVEPATH} -type f -name "*log*" | sort

#}
elif [ "${1}" == "aft" ]
then
#{
    echo "### After"
  
    func_DEBUG "${LINENO}: Copy Msglog and Diff"
    cd ${SAVEPATH}
    befmsg=`ls msg*.log`
    aftmsg=msg`date +%y%m%d`.log
    if [ "${befmsg}" == "${aftmsg}" ]
    then
        func_DEBUG "${LINENO}: Today"
        func_Diff ${befmsg} /SYSTEM/LOG/msglog/${befmsg} ${befmsg}_aft
    else
        func_DEBUG "${LINENO}: Yesterday + Today"
        func_Diff ${befmsg} /SYSTEM/LOG/msglog/${befmsg} ${befmsg}_aft
        cat /SYSTEM/LOG/msglog/${aftmsg} >> ${befmsg}_aft
    fi
    mv ${befmsg}_aft ${befmsg}

    func_DEBUG "${LINENO}: Copy FS CORE and Diff"
    cd ${SAVEPATH}/Core/FS
    for item in "${FSITEM[@]}"
    do
    #{
        # Change DDDD,NAME -> DDDD/NAME
        pth=`echo ${item} | sed -e 's/,/\//g'`
        pid=`echo ${item} | cut -d , -f1`
        fnm=`echo ${item} | cut -d , -f2`
        svf=$( printf "%04d" $pid )_${fnm}
 
        # 保存DIR 配下に .oldがあれば、/SYSTEM/CORE/core/???/*.old と差分があるチェック
        # ある場合は、.log がローテーションしたと判断  
        if [ -f /SYSTEM/CORE/core/${pth}.old ]; then
            func_DEBUG "${LINENO}: Exist /SYSTEM/CORE/core/${pth}.old"
            # /SYSTEM/CORE/core 配下に .old がある場合は 保存DIR 配下に .old があるかをチェック 
            if [ -f ${svf}.old ]; then
                func_DEBUG "${LINENO}: Exist ${SAVEPATH}/Core/FS/${svf}.old"
                # 保存DIR 配下に .old がある場合
                if [ `diff -q ${svf}.old /SYSTEM/CORE/core/${pth}.old | wc -l` == 1 ]; then
                    func_DEBUG "${LINENO}: Different /SYSTEM/CORE/core/${pth}.old ${SAVEPATH}/Core/FS/${svf}.old"
                    # 差分がある場合は .log がローテーションしたとみなす 
                    func_Diff ${svf}.log /SYSTEM/CORE/core/${pth}.old ${svf}.log_aft
                    cat /SYSTEM/CORE/core/${pth}.log >> ${svf}.log_aft
                else
                    func_DEBUG "${LINENO}: Equal /SYSTEM/CORE/core/${pth}.old ${SAVEPATH}/Core/FS/${svf}.old"
                    # 差分がない場合は .log のみ差分を抽出 
                    func_Diff ${svf}.log /SYSTEM/CORE/core/${pth}.log ${svf}.log_aft
                fi
            else
                func_DEBUG "${LINENO}: No ${SAVEPATH}/Core/FS/${svf}.old"
                # 保存DIR 配下に .old がない場合は、.log がローテーションしたとみなす 
                func_Diff ${svf}.log /SYSTEM/CORE/core/${pth}.old ${svf}.log_aft
                cat /SYSTEM/CORE/core/${pth}.log >> ${svf}.log_aft
            fi
        else
            func_DEBUG "${LINENO}: No /SYSTEM/CORE/core/${pth}.old"
            # /SYSTEM/CORE/core 配下に .old がない場合は 保存DIR 配下にも .old がないので、
            # .log を比較するのみ 
            func_Diff ${svf}.log /SYSTEM/CORE/core/${pth}.log ${svf}.log_aft
        fi
 
        # 不要ファイル削除 
        rm -f ${svf}.old ${svf}.log
        mv ${svf}.log_aft ${svf}.log
    #}
    done

    func_DEBUG "${LINENO}: Copy USP CORE and Diff"
    for uno in `seq 0 $(( ${USPMAX} - 1 ))`
    do
    #{
        uspnm=$( printf "USP%02d" $uno )
        cd ${SAVEPATH}/Core/${uspnm}

        for item in "${USPITEM[@]}"
        do
        #{
            func_DEBUG "${LINENO}: Get Item = ${item}"
            pth=`echo ${item} | sed -e 's/,/\//g'`
            pid=`echo ${item} | cut -d , -f1`
            fnm=`echo ${item} | cut -d , -f2`
            svf=$( printf "%04d" $pid )_${fnm}

            # 1) COPY
            scp -p ${uspnm}:/SYSTEM/CORE/core/${pth}.old ${SAVEPATH}/Core/${uspnm}/${svf}.old_aft 1>&/dev/null
            scp -p ${uspnm}:/SYSTEM/CORE/core/${pth}.log ${SAVEPATH}/Core/${uspnm}/${svf}.log_aft

            # 2) CHECK & DIFF
            if [ -f ${svf}.old_aft ]; then
                if [ -f ${svf}.old_bef ]; then
                    if [ `diff -q ${svf}.old_bef ${svf}.old_aft | wc -l` -eq 1 ]; then
                        func_DEBUG "${LINENO}: Different ${svf}.old_bef ${svf}.old_aft"
                        func_Diff ${svf}.log_bef ${svf}.old_aft ${svf}.log
                        cat ${svf}.log_aft >> ${svf}.log
                    else
                        func_DEBUG "${LINENO}: Equal ${svf}.old_bef ${svf}.old_aft"
                        func_Diff ${svf}.log_bef ${svf}.log_aft ${svf}.log
                    fi
                else
                    func_DEBUG "${LINENO}: No ${svf}.old_bef"
                    func_Diff ${svf}.log_bef ${svf}.old_aft ${svf}.log
                    cat ${svf}.log_aft >> ${svf}.log
                fi
            else
                func_DEBUG "${LINENO}: No ${svf}.old_aft"
                func_Diff ${svf}.log_bef ${svf}.log_aft ${svf}.log
            fi
            # remove
            rm -f ${svf}.log_* ${svf}.old_*
        #}
        done
    #}
    done

    # compress
    cd ${SAVEPATH}
    #tar czvf ./MSGandCORE.tgz ./msg*.log ./Core 1>/dev/null 2>/dev/null
    tar czvf ./${TGZFILE} ./msg*.log ./Core 1>/dev/null 2>/dev/null
    rm -rf ./msg*.log ./Core 1>/dev/null 2>/dev/null
#}
else
#{
    echo "
    [Usage] ${TOOLNAME} STEP
        STEP: 工程.
                bef: 試験前.
                aft: 試験後. ${SAVEPATH}/${TGZFILE} を吸い上げること.
"
#}
fi

```



## 附录：Shell逻辑运算总结

> 1. 关于文件和目录
> 例如[ -f file ]
> -f  判断某普通文件是否存在
> -d  判断某目录是否存在
> -b  判断某文件是否块设备
> -c  判断某文件是否字符设备
> -S  判断某文件是否socket（待修正）
> -L  判断某文件是否为符号链接（待修正）
> -e  判断某东西是否存在（待修正）
> -p  判断某文件是否为pipe 或是 FIFO
>
> 2. 关于文件的属性
> -r  判断文件是否为可读的属性
> -w  判断文件是否为可以写入的属性
> -x  判断文件是否为可执行的属性
> -s  判断文件是否为非空白文件
> -u  判断文件是否具有SUID的属性
> -g  判断文件是否具有SGID的属性
> -k  判断文件是否具有sticky bit的属性
>
> 3. 两个文件之间的判断与比较
> 例如[ test file1 -nt file2 ]
> -nt  第一个文件比第二个文件新
> -ot  第一个文件比第二个文件旧
> -ef  第一个文件与第二个文件为同一个（ link 之类的文件）
>
> 4. 逻辑的(and)与(or)
> &&   逻辑的 AND 的意思, -a 也是这个意思
> ||  逻辑的 OR 的意思， -o 也是这个意思
>
> 5. 运算符相关
>    运算符号代表意义
>    =  等于  应用于：整型或字符串比较 如果在[] 中，只能是字符串
>    !=  不等于 应用于：整型或字符串比较 如果在[] 中，只能是字符串
>    <  小于 应用于：整型比较 在[] 中，不能使用 表示字符串
>
>    大于 应用于：整型比较 在[] 中，不能使用 表示字符串
>    -eq  等于 应用于：整型比较
>    -ne  不等于 应用于：整型比较
>    -lt  小于 应用于：整型比较
>    -gt  大于 应用于：整型比较
>    -le  小于或等于 应用于：整型比较
>    -ge  大于或等于 应用于：整型比较
>    -a  双方都成立（and） 逻辑表达式 –a 逻辑表达式
>    -o  单方成立（or） 逻辑表达式 –o 逻辑表达式
>    -z  空字符串
>    -n  非空字符串

