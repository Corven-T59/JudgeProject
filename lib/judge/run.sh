#!/bin/bash
#//////////////////////////////////////////////////////////////////////////////////////////
#//BOCA Online Contest Administrator. Copyright (c) 2003- Cassio Polpo de Campos.
#//It may be distributed under the terms of the Q Public License version 1.0. A copy of the
#//license can be found with this software or at http://www.opensource.org/licenses/qtpl.php
#//
#//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
#//INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
#//PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS. IN NO EVENT SHALL THE COPYRIGHT HOLDER
#//OR HOLDERS INCLUDED IN THIS NOTICE BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL INDIRECT OR
#//CONSEQUENTIAL DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
#//PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING
#//OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#///////////////////////////////////////////////////////////////////////////////////////////
#Last modified: 10/aug/2009 by cassio@ime.usp.br
#
# parameters are:
# $1 base_filename
# $2 source_file
# $3 input_file
# $4 languagename
# $5 problemname
# $6 timelimit
#
# the output of the submission should be directed to the standard output
#
# the return code show what happened:
# 0 ok
# 1 compile error
# 2 runtime error
# 3 timelimit exceeded
# other_codes are unknown to boca: in this case BOCA will present the
#                                  last line of standard output to the judge

umask 0022
chown nobody.nogroup .
export CLASSPATH=.:$CLASSPATH

# this script makes use of safeexec to execute the code with less privilegies
# make sure that directories below are correct.
sf=`which safeexec`
[ -x "$sf" ] || sf=/usr/bin/safeexec
gcc=`which gcc`
[ -x "$gcc" ] || gcc=/usr/bin/gcc
gpp=`which g++`
[ -x "$gpp" ] || gpp=/usr/bin/g++
java=`which java`
[ -x "$java" ] || java=/usr/java/bin/java
javac=`which javac`
[ -x "$javac" ] || javac=/usr/java/bin/javac
mcs=`which mcs`
[ -x "$mcs" ] || mcs=/usr/bin/mcs
mono=`which mono`
[ -x "$mono" ] || mono=/usr/bin/mono
#ruby=`which ruby`
[ -x "$ruby" ] || ruby=/usr/bin/ruby
python=`which python`
[ -x "$python" ] || python=/usr/bin/python
python3=`which python3`
[ -x "$python3" ] || python3=/usr/bin/python
grep=`which grep`
[ -x "$grep" ] || grep=/bin/grep

if [ "$1" == "" -o "$2" == "" -o "$3" == "" ]; then
    echo "parameter problem"
    exit 43
fi
if [ ! -r "$2" ]; then
    echo "$2 not found or it's not readable"
    exit 44
fi
if [ ! -r "$3" ]; then
    echo "$3 not found or it's not readable"
    exit 45
fi
if [ ! -x "$sf" ]; then
    echo "$sf not found or it's not executable"
    exit 46
fi

prefix=$1
name=$2
input=$3

# setting up the timelimit according to the problem
# note that problems should spelling the same as inside BOCA
if [ "$6" == "" ]; then
time=5
else
time=$6
fi
let ttime=$time+30

# choose the compiler according to the language
# note that languages should spelling the same as inside BOCA
case "$4" in
c)
	$gcc -lm -o "$prefix" "$name"
	ret=$?
	if [ "$ret" != "0" ]; then
		echo "C Compiling Error: $ret"
		exit 1
	else
		$sf -F10 -t$time -T$ttime -i$input -n0 -R. "./$prefix" -U 1002 -G 1002
		ret=$?
		if [ $ret -gt 3 ]; then
            ret=0
		fi
	fi
	;;
cpp)
	$gpp -lm -o "$prefix" "$name"
	ret=$?
	if [ "$ret" != "0" ]; then
		echo "C++ Compiling Error: $ret"
		exit 1
	else
		$sf -F10 -t$time -T$ttime -i$input -n0 -R. "./$prefix" -U 1002 -G 1002
		ret=$?
		if [ $ret -gt 3 ]; then
            ret=0
		fi
	fi
	;;
csharp)
	$mcs -out:"$prefix" "$name"
	ret=$?
	if [ "$ret" != "0" ]; then
		echo "C# Compiling Error: $ret"
		exit 1
	else
		$sf -F10 -t$time -T$ttime -i$input -n0 -R. $mono "$prefix" -U 1002 -G 1002
		ret=$?
		if [ $ret -gt 3 ]; then
            echo "Nonzero return code - possible runtime error on C#"
		    ret=47
		fi
	fi
	;;
java)
	$javac "$name"
	ret=$?
	if [ "$ret" != "0" ]; then
		echo "Java Compiling Error: $ret"
		exit 1
	else
		$sf -u10 -F30 -t$time -T$ttime -i$input -n0 -R. -F256 -u256 -U 1002 -G 1002 -n0 -C. -f20000 -d20000000 -m20000000 -- $java -Xmx512000K -Xms512000K "$prefix"
		ret=$?
		if [ $ret -gt 3 ]; then
		    echo "Nonzero return code - possible runtime error on java"
		    ret=47
		fi
	fi
	;;
rb)
    $sf -F30 -t$time -T$ttime -i$input -n0 -R. $ruby "$name" -U 1002 -G 1002
    ret=$?
    if [ $ret -gt 3 ]; then
        echo "Nonzero return code - possible runtime error on Ruby: "$?
        ret=47
    fi
    ;;
py2)
    $sf -F30 -t$time -T$ttime -i$input -n0 -R. $python "$name" -U 1002 -G 1002
    ret=$?
    if [ $ret -gt 3 ]; then
        echo "Nonzero return code - possible runtime error on Python2: "$?
        ret=47
    fi
    ;;
py3)
    $sf -F30 -t$time -T$ttime -i$input -n0 -R. $python3 "$name" -U 1002 -G 1002
    ret=$?
    if [ $ret -gt 3 ]; then
        echo "Nonzero return code - possible runtime error on Python3: "$?
        ret=47
    fi
    ;;
*)
	echo "Language not recognized"
	exit 42
	;;
esac
exit $ret
