/**
 * let URL_BASE = '/dms/';
 */ 
let URL_BASE = '/';
let URLS = {
    'alarm_info_get':'alarm-info/info/',
};

let DOMAIN = window.location.host;
let PORT = window.location.port;

let rankColorMap = {
    '1': '#2cb9a7',
    '2': '#108ae0',
    '3': '#ea9d41',
    '4': '#ea7141',
    '5': '#ff4f4f'
};

let rankNameColorMap = {
    '信息': '#2cb9a7',
    '轻微': '#108ae0',
    '一般': '#ea9d41',
    '重要': '#ea7141',
    '严重': '#ff4f4f'
};

let rankNameMap = {
    '1': '信息',
    '2': '轻微',
    '3': '一般',
    '4': '重要',
    '5': '严重',
};

let nameRankMap = {
    '信息': '1',
    '轻微': '2',
    '一般': '3',
    '重要': '4',
    '严重': '5',
};

function getRankName(rank) {
    rank = rank + '';
    if (rank === '-' || !rank) {
        return rank;
    } else {
        return rankNameMap[rank];
    }
}

function getNameRank(name) {

    if (name === '-' || !name) {
        return name;
    } else {
        return nameRankMap[name];
    }
}

let loadingStyle = {
    text: '加载中',
    color: '#ff4f4f',
    textColor: '#ff4f4f',
    maskColor: 'rgba(255, 255, 255, 0)',
};

function request(url, data, method, dataType, success, error, contentType) {
    if(!url){
        return;
    }

    let qUrl = URL_BASE + url;

    if (url.charAt(0) === '/') {
        qUrl = url;
    }

    let param = {
        url: qUrl,
        type: method || 'GET',
        contentType: contentType || "application/json;charset=utf-8",
        success: success,
        error: function (data) {
            let ret = false;
            if (typeof error === 'function') {
                ret = error(data);
            }
            if (!ret) {
                // let pathname =  top.window.location.pathname;
                // let index = pathname.lastIndexOf('/') + 1;
                // let prefix = pathname.slice(0, index);
                // if (data.status === 307) {
                //     top.window.location = prefix + 'login';
                // } else if(data.status === 511){
                //     top.window.location = prefix + 'error';
                // }
                if (data.status === 307) {
                    top.window.location = getBaseUrl() + 'login';
                } else if(data.status === 511){
                    top.window.location = getBaseUrl() + 'error';
                }
            }
        }
    };

    if (dataType) {
        param['dataType'] = dataType;
    }

    if (data) {
        if (method.toLowerCase() === 'post' || method.toLowerCase() === 'put') {
            param['data'] = JSON.stringify(data);
        } else {
            param['data'] = data;
        }
    }

    return $.ajax(param);
}

function requestJson(url, data, method, success, error) {
    request(url, data, method, 'json', success, error);
}

function requestPlan(url, data, method, success, error) {
    request(url, data, method, '', success, error);
}

function uploadFile(url, data, success, error, type) {
    if(!url){
        return;
    }

    let qUrl = URL_BASE + url;

    if (url.charAt(0) === '/') {
        qUrl = url;
    }

    $.ajax({
        url: qUrl,
        type: type ? type : 'POST',
        data: data,
        xhrFields: {
            withCredentials: true //发送请求时，携带用户标识的cookie
        },
        processData: false,// ⑧告诉jQuery不要去处理发送的数据
        contentType: false, // ⑨告诉jQuery不要去设置Content-Type请求头
        success: success,
        error : error
    });
}

function getUrlParams() {
    let url = location.search;
    let params = new Object();
    if (url.indexOf("?") != -1) {
        let str = url.substr(1);
        let strs = str.split("&");
        for(let i = 0; i < strs.length; i ++) {
            params[strs[i].split("=")[0]]=decodeURIComponent(strs[i].split("=")[1]);
        }
    }

    return params;
}

function downloadFile(url, data, method){
    if(!url){
        return;
    }

    let qUrl = URL_BASE + url;
    if (url.charAt(0) === '/') {
        qUrl = url;
    }
    let inputs = '';
    if( data ){
        if (typeof data === 'string') {
            $.each(data.split('&'), function(){
                let pair = this.split('=');
                inputs+='<input type="hidden" name="'+ pair[0] +'" value="'+ pair[1] +'" />';
            });
        } else {
            for (let k in data) {
                inputs+='<input type="hidden" name="'+ k +'" value="'+ data[k] +'" />';
            }
        }
    }
    $('<form action="'+ qUrl +'" method="'+ (method||'post') +'">'+inputs+'</form>').appendTo('body').submit().remove();
}


(function () {
    /// <summary>
    /// 引号转义符号
    /// </summary>
    String.EscapeChar = '\'';

    /// <summary>
    /// 替换所有字符串
    /// </summary>
    /// <param name="searchValue">检索值</param>
    /// <param name="replaceValue">替换值</param>
    String.prototype.replaceAll = function (searchValue, replaceValue) {
        let regExp = new RegExp(searchValue, "g");
        return this.replace(regExp, replaceValue);
    }

    /// <summary>
    /// 格式化字符串
    /// </summary>
    String.prototype.format = function () {
        let regexp = /\{(\d+)\}/g;
        let args = arguments;
        let result = this.replace(regexp, function (m, i) {
            return args[i];
        });
        return result.replaceAll('%', String.EscapeChar);
    }
})();

function getBaseUrl() {
    let pathname =  top.window.location.pathname;
    let origin = top.window.location.origin;

    let domain = pathname.split('/'); // 以“/”进行分割

    if( domain[1] && domain.length > 3 ) {
        domain = origin + '/' + domain[1] + '/'; // 如果 url 存在一层目录
    } else {
        domain = origin + '/'; // 如果 url 是根目录
    }

    return domain;
}

function shorterText(text, length, isTitle) {
    if (!text) {
        return '';
    }
    text = characterFullToHalf(text.replace(/\\"/g, '”'));
    if (isTitle) {
        return text;
    } else {
        length = length || 10;
        if(text.length > length){
            return text.slice(0, length-1) + '...';
        } else {
            return text;
        }
    }
}

function indexFormatter(value, row, index) {
    return index + 1;
}

function numberFormatter(value){
    let hundredMillion = 100000000;
    let tenThousand = 10000;
    let thousand = 1000;

    if (value > hundredMillion){
        return parseInt(value / hundredMillion) + '亿';
    } else if (value > tenThousand){
        return parseInt(value / tenThousand)  + '万';
    } else if(value > thousand){
        return parseInt(value / thousand)  + '千';
    }else {
        return value;
    }
}

function timeFormatter(value, format) {
    if (value !== 0 && !value) {
        return '';
    }

    format = format || 'YYYY-MM-DD HH:mm:ss';
    return moment(new Date(value)).format(format);
}

function tableTimeFormatter(data) {
    if (data) {
        return timeFormatter(data);
    } else {
        return '-';
    }
}

function getQueryParams(){
    let url = location.search;
    let params = {};

    if (url.indexOf('?') !== -1) {
        let str = url.substr(1);
        let strs = str.split('&');
        for (let i = 0; i < strs.length; i++) {
            params[strs[i].split('=')[0]] = strs[i].split('=')[1];
        }
    }

    return params;
}

function floatSame(left, right) {
    return Math.abs(left - right) < Number.EPSILON * Math.pow(2, 2);
}

function htmlEscape(text) {
    if (text) {
        return text.replace(/</g,'&lt;').replace(/>/g,'&gt;');
    } else {
        return '';
    }
}

function characterFullToHalf(str){
    let tmp = "";
    if (str) {
        for (let i=0;i<str.length;i++) {
            if(str.charCodeAt(i) >= 65281 && str.charCodeAt(i) <= 65374){// 如果位于全角！到全角～区间内
                tmp += String.fromCharCode(str.charCodeAt(i)-65248)
            }else if(str.charCodeAt(i) === 12288){//全角空格的值，它没有遵从与ASCII的相对偏移，必须单独处理
                tmp += ' ';
            }else{// 不处理全角空格，全角！到全角～区间外的字符
                tmp += str[i];
            }
        }
    }
    return tmp;
}

/**
 * iframe 加载完成 执行操作
 * @author 宋燃
 * @time 2021/11/08 下午 4:22
 * @param iframe
 * @param fn
 */
function iframeReady(iframe, fn) {
    //iframe 加载完成
    if (iframe.attachEvent) {
        iframe.attachEvent("onload", function () {
            fn && fn.call(iframe);
        });
    } else {
        //iframe 加载未完成
        iframe.onload = function () {
            fn && fn.call(iframe);
        };
    }
}

/**
 * 判断是否是json对象
 * @author 宋燃
 * @time 2021/11/08 下午 2:30
 * @param value
 * @return {boolean}
 */
function isJSON(value) {
    if (typeof value == 'string') {
        try {
            let obj = JSON.parse(value);
            if (typeof obj == 'object' && obj) {
                return true;
            } else {
                return false;
            }

        } catch (e) {
            // console.log('error：' + value + '???' + e);
            return false;
        }
    }
}

/**
 * object 遍历/过滤 json
 * @author 宋燃
 * @time 2021/11/08 下午 2:31
 * @param map
 * @return {Object|string}
 */
function filterMaps(map) {
    let maps = map;

    if (typeof maps === 'string') {
        if (isJSON(map)) {
            maps = JSON.parse(map)
        }
    }

    if (typeof maps == 'object' && maps) {
        for (let key in maps) {
            let value = maps[key];
            let _json = value;

            if (typeof value === 'string') {
                if (isJSON(value)) {
                    _json = JSON.parse(value)
                }
            }

            if (typeof _json === 'object' && _json) {
                maps[key] = filterMaps(value);
            } else {
                maps[key] = value
            }
        }
    }

    return maps
}

/**
 * object 遍历/过滤 为 map 键-值
 * @author 宋燃
 * @time 2021/11/08 下午 4:31
 * @param map
 * @param keyName
 * @return {Object|string}
 */
let mapsToKey = {};
function filterMapsToKey(map, keyName) {
    let maps = {};

    if (typeof map === 'string') {
        if (isJSON(map)) {
            map = JSON.parse(map)
        }
    }

    if (typeof map == 'object' && map) {
        for (let key in map) {
            let value = map[key];
            let _json = value;

            if (typeof value === 'string') {
                if (isJSON(value)) {
                    _json = JSON.parse(value)
                }
            }

            if (typeof _json === 'object' && _json) {
                if (keyName) {
                    maps[(keyName + '.' + key)] = filterMapsToKey(value, (keyName + '.' + key));
                } else {
                    maps[key] = filterMapsToKey(value, key);
                }
            } else {
                maps[key] = value
            }
        }
    }

    for (let k in maps) {
        let v = map[k];

        if (typeof v === 'string') {
            if (isJSON(v)) {} else {
                let name = keyName ? (keyName + '.' + k) : k;
                mapsToKey[name] = v
            }
        }
    }

    return mapsToKey
}

/**
 * @description document.hidden 在浏览器兼容上做一些前缀处理
 * @author songran
 * @time 2021/11/08 11:45
 * @returns {*}
 */
function getHiddenProp() {
    let prefixes = ['webkit','moz','ms','o'];

    if ('hidden' in document) return 'hidden';

    for (let i = 0; i < prefixes.length; i++) {
        if ((prefixes[i] + 'Hidden') in document)
            return prefixes[i] + 'Hidden';
    }

    return null;
}

/**
 * @description  获取 document.visibilityState 属性
 * @author songran
 * @time 2021/11/08 11:43
 * @returns {*}
 */
function getVisibilityState() {
    let prefixes = ['webkit', 'moz', 'ms', 'o'];

    if ('visibilityState' in document) return 'visibilityState';

    for (let i = 0; i < prefixes.length; i++) {
        if ((prefixes[i] + 'VisibilityState') in document)
            return prefixes[i] + 'VisibilityState';
    }

    return null;
}

/**
 * @description 使用属性名生成带前缀的事件名
 * @author songran
 * @time 2021/11/08 11:43
 * @type {*}
 */
let visProp = getHiddenProp();
if (visProp) {
    let evtname = visProp.replace(/[H|h]idden/, '') + 'visibilitychange';

    document.addEventListener(evtname, function () {
        // document.title = document[getVisibilityState()]+"状态";
    }, false);
}