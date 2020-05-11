#!/bin/sh


function getTime(){
    cur_sec_and_ns=`date '+%s-%N'`
    cur_sec=${cur_sec_and_ns%-*}
    cur_ns=${cur_sec_and_ns##*-}
    cur_timestamp=$((cur_sec*1000+$((10#$cur_ns))/1000000))
    echo $cur_timestamp
}

function rand(){   
    min=$1   
    max=$(($2-$min+1))   
    num=$(date +%s%N)   
    echo $(($num%$max+$min))   
} 

path=`dirname $0`
filePath=${path}"/../logs/area.log"
if [ ! -f $filePath ];then
    touch $filePath
fi
#清空文件
`truncate -s 0 $filePath`
array=("北京" "天津" "上海" "重庆" "石家庄" "唐山" "秦皇岛" "邯郸" "邢台" "保定" "张家口" "承德" "沧州" "廊坊" "衡水" "太原" "大同" "阳泉" "长治" "晋城" "朔州" "晋中" "运城" "忻州" "临汾" "吕梁" "沈阳" "大连" "鞍山" "抚顺" "本溪" "丹东" "锦州" "营口" "阜新" "辽阳" "盘锦" "铁岭" "朝阳" "葫芦岛市" "长春" "吉林" "四平" "辽源" "通化" "白山" "松原" "白城" "延边朝鲜族自治州" "哈尔滨" "齐齐哈尔" "鸡西" "鹤岗" "双鸭山" "大庆" "伊春" "佳木斯" "七台河" "牡丹江" "黑河" "绥化" "大兴安岭地区" "南京" "无锡" "徐州" "常州" "苏州" "南通" "连云港" "淮安" "盐城" "扬州" "镇江" "泰州" "宿迁" "杭州" "宁波" "温州" "嘉兴" "湖州" "绍兴" "金华" "衢州" "舟山" "台州" "丽水" "合肥" "芜湖" "蚌埠" "淮南" "马鞍山" "淮北" "铜陵" "安庆" "黄山" "滁州" "阜阳" "宿州" "六安" "亳州" "池州" "宣城" "福州" "厦门" "莆田" "三明" "泉州" "漳州" "南平" "龙岩" "宁德" "南昌" "景德镇" "萍乡" "九江" "新余" "鹰潭" "赣州" "吉安" "宜春" "抚州" "上饶" "济南" "青岛" "淄博" "枣庄" "东营" "烟台" "潍坊" "济宁" "泰安" "威海" "日照" "莱芜" "临沂" "德州" "聊城" "滨州" "菏泽" "郑州" "开封" "洛阳" "平顶山" "安阳" "鹤壁" "新乡" "焦作" "濮阳" "许昌" "漯河" "三门峡" "南阳" "商丘" "信阳" "周口" "驻马店" "济源" "武汉" "黄石" "十堰" "宜昌" "襄阳" "鄂州" "荆门" "孝感" "荆州" "黄冈" "咸宁" "随州" "恩施土家族苗族自治州" "潜江" "神农架林区" "天门" "仙桃" "长沙" "株洲" "湘潭" "衡阳" "邵阳" "岳阳" "常德" "张家界" "益阳" "郴州" "永州" "怀化" "娄底" "湘西土家族苗族自治州" "广州" "韶关" "深圳" "珠海" "汕头" "佛山" "江门" "湛江" "茂名" "肇庆" "惠州" "梅州" "汕尾" "河源" "阳江" "清远" "东莞" "中山" "潮州" "揭阳" "云浮" "东沙群岛" "白沙黎族自治县" "保亭黎族苗族自治县" "昌江黎族自治县" "澄迈县" "海口" "三亚" "三沙" "儋州" "定安县" "东方" "乐东黎族自治县" "临高县" "陵水黎族自治县" "琼海" "琼中黎族苗族自治县" "屯昌县" "万宁" "文昌" "五指山" "成都" "自贡" "攀枝花" "泸州" "德阳" "绵阳" "广元" "遂宁" "内江" "乐山" "南充" "眉山" "宜宾" "广安" "达州" "雅安" "巴中" "资阳" "阿坝藏族羌族自治州" "甘孜藏族自治州" "凉山彝族自治州" "贵阳" "六盘水" "遵义" "安顺" "毕节" "铜仁" "黔西南布依族苗族自治州" "黔东南苗族侗族自治州" "黔南布依族苗族自治州" "昆明" "曲靖" "玉溪" "保山" "昭通" "丽江" "普洱" "临沧" "楚雄彝族自治州" "红河哈尼族彝族自治州" "文山壮族苗族自治州" "西双版纳傣族自治州" "大理白族自治州" "德宏傣族景颇族自治州" "怒江傈僳族自治州" "迪庆藏族自治州" "西安" "铜川" "宝鸡" "咸阳" "渭南" "延安" "汉中" "榆林" "安康" "商洛" "兰州" "嘉峪关" "金昌" "白银" "天水" "武威" "张掖" "平凉" "酒泉" "庆阳" "定西" "陇南" "临夏回族自治州" "甘南藏族自治州" "西宁" "海东" "海北藏族自治州" "黄南藏族自治州" "海南藏族自治州" "果洛藏族自治州" "玉树藏族自治州" "海西蒙古族藏族自治州" "台湾省" "呼和浩特" "包头" "乌海" "赤峰" "通辽" "鄂尔多斯" "呼伦贝尔" "巴彦淖尔" "乌兰察布" "兴安盟" "锡林郭勒盟" "阿拉善盟" "南宁" "柳州" "桂林" "梧州" "北海" "防城港" "钦州" "贵港" "玉林" "百色" "贺州" "河池" "来宾" "崇左" "拉萨" "日喀则" "昌都" "林芝" "山南" "那曲区" "阿里地区" "银川" "石嘴山" "吴忠" "固原" "中卫" "阿拉尔" "北屯" "可克达拉" "昆玉" "石河子" "双河市" "乌鲁木齐" "克拉玛依" "吐鲁番" "哈密" "昌吉回族自治州" "博尔塔拉蒙古自治州" "巴音郭楞蒙古自治州" "阿克苏地区" "克孜勒苏柯尔克孜自治州" "喀什地区" "和田地区" "伊犁哈萨克自治州" "塔城地区" "阿勒泰地区" "铁门关" "图木舒克" "五家渠" "香港特别行政区" "澳门特别行政区")
initcap=5000
ts=$(getTime)
#初始化数据
#for((i=0;i<=49;i++)) do
#    echo -e "$ts\t$(((50-$i)*$initcap))\t${array[$i]}" >> $filePath
#done
#生产数据
while true
do
    ts=$(getTime)
    for((i=0;i<=49;i++)) do
	index=$(rand 0 370)
        num=$(rand 1000 100000)
        echo -e "$ts\t$num\t${array[$index]}" >> $filePath
    done
    sleep 0.8
done

