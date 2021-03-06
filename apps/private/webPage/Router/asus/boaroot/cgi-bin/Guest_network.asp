<%
tcWebApi_set("WLan_Common","editFlag","editFlag")
tcWebApi_set("WLan_Common","MBSSID_changeFlag","MBSSID_changeFlag")
tcWebApi_set("WLan_Common","MBSSID_able_Flag","MBSSID_able_Flag")
If Request_Form("editFlag") = "1" then
	tcWebApi_Set("SysInfo_Entry","w_Setting","w_Setting")
	tcWebApi_commit("SysInfo_Entry")	
	tcWebApi_Set("WLan_Common","wl_unit","wl_unit")
	tcWebApi_Set("WLan_Common","wl_subunit","wl_subunit")

	load_parameters_to_generic()

	tcWebApi_Set("WLan_Entry","ssid","wl_ssid")
	tcWebApi_Set("WLan_Common","WirelessMode","wl_nmode_orig")
	tcWebApi_Set("WLan_Entry","auth_mode_x","wl_auth_mode_save")
	tcWebApi_Set("WLan_Entry","crypto","wl_crypto_save")
	tcWebApi_Set("WLan_Entry","wpa_psk","wl_wpa_psk")
	tcWebApi_Set("WLan_Entry","wep_x","wl_wep_x")
	tcWebApi_Set("WLan_Entry","key","wl_key")
	tcWebApi_Set("WLan_Entry","key1","wl_key1")
	tcWebApi_Set("WLan_Entry","key2","wl_key2")
	tcWebApi_Set("WLan_Entry","key3","wl_key3")
	tcWebApi_Set("WLan_Entry","key4","wl_key4")
	tcWebApi_Set("WLan_Entry","phrase_x","wl_phrase_x")
	tcWebApi_Set("WLan_Entry","expire","wl_expire")
	tcWebApi_Set("WLan_Entry","lanaccess","wl_lanaccess")	
	tcWebApi_Set("WLan_Entry","wl0.1_bss_enabled","wl0.1_bss_enabled")
	tcWebApi_Set("WLan_Entry","wl0.2_bss_enabled","wl0.2_bss_enabled")
	tcWebApi_Set("WLan_Entry","wl0.3_bss_enabled","wl0.3_bss_enabled")
	tcWebApi_Set("WLan_Entry","wl1.1_bss_enabled","wl1.1_bss_enabled")
	tcWebApi_Set("WLan_Entry","wl1.2_bss_enabled","wl1.2_bss_enabled")
	tcWebApi_Set("WLan_Entry","wl1.3_bss_enabled","wl1.3_bss_enabled")		
	tcWebApi_Set("WLan_Entry","wl_macmode","wl_macmode")
	tcWebApi_Set("WLan_Entry","wl_maclist","wl_maclist")	

	If Request_Form("MBSSID_able_Flag") = "0" then
	load_MBSSID_parameters_from_generic()
	end if

	tcWebApi_Commit("WLan_Entry")
	tcWebApi_Commit("ACL_Entry")
end if

load_MBSSID_parameters_to_generic()
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<html xmlns:v>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=Edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta HTTP-EQUIV="Pragma" CONTENT="no-cache">
<meta HTTP-EQUIV="Expires" CONTENT="-1">
<link rel="shortcut icon" href="/images/favicon.png">
<link rel="icon" href="/images/favicon.png">
<title>ASUS <%tcWebApi_get("String_Entry","Web_Title2","s")%> <% tcWebApi_staticGet("SysInfo_Entry","ProductTitle","s") %> - <%tcWebApi_get("String_Entry","Guest_Network","s")%></title>
<link rel="stylesheet" type="text/css" href="/index_style.css">
<link rel="stylesheet" type="text/css" href="/form_style.css">
<link rel="stylesheet" type="text/css" href="/usp_style.css">
<link href="/other.css"  rel="stylesheet" type="text/css">
<script type="text/javascript" src="/state.js"></script>
<script type="text/javascript" src="/help.js"></script>
<script type="text/javascript" src="/general.js"></script>
<script type="text/javascript" src="/popup.js"></script>
<script type="text/javascript" src="/client_function.js"></script>
<script type="text/javascript" src="/md5.js"></script>
<script type="text/javascript" src="/detect.js"></script>
<style>
.WL_MAC_Block{
	border:1px outset #999;
	background-color:#576D73;
	position:absolute;
	*margin-top:27px;	
	margin-left:107px;
	*margin-left:-133px;
	width:255px;
	text-align:left;	
	height:auto;
	overflow-y:auto;
	z-index:200;
	padding: 1px;
	display:none;
}
.WL_MAC_Block div{
	background-color:#576D73;
	height:auto;
	*height:20px;
	line-height:20px;
	text-decoration:none;
	font-family: Lucida Console;
	padding-left:2px;
}
.WL_MAC_Block a{
	background-color:#EFEFEF;
	color:#FFF;
	font-size:12px;
	font-family:Arial, Helvetica, sans-serif;
	text-decoration:none;	
}
.WL_MAC_Block div:hover, .WL_MAC_Block a:hover{
	background-color:#3366FF;
	color:#FFFFFF;
	cursor:default;
}
</style>
<script>
wan_route_x = '';
wan_nat_x = '1';
wan_proto = 'dhcp';
var radio_2 = '<% tcWebApi_get("WLan_Entry","wl0_radio_on","s") %>';
var radio_5 = '<% tcWebApi_get("WLan_Entry","wl1_radio_on","s") %>';

var wl0_nmode_x = '<% tcWebApi_get("WLan_Common","wl0_WirelessMode","s") %>';
var wl1_nmode_x = '<% tcWebApi_get("WLan_Common","wl1_WirelessMode","s") %>';

var modify_mode = '<% get_parameter("flag"); %>';	//Viz keep Confirm

var gn_array = gn_array_2g;
var wl_maclist_x_array = decodeURIComponent(gn_array[0][16]).replace(/&#60/g, "<");

var manually_maclist_list_array = new Array();
Object.prototype.getKey = function(value) {
	for(var key in this) {
		if(this[key] == value) {
			return key;
		}
	}
	return null;
};

function initial(){
	show_menu();
	//insertExtChannelOption();
	//if(downsize_support != -1)
	//	document.getElementById("guest_image").parentNode.style.display = "none";	

	mbss_display_ctrl();
	gen_gntable();	
	guest_divctrl(0);

	if(document.form.wl_gmode_protection.value == "auto")
		document.form.wl_gmode_check.checked = true;
	else
		document.form.wl_gmode_check.checked = false;

	if(band5g_support == -1 || no5gmssid_support != -1){
		document.getElementById("guest_table5").style.display = "none";
	}

	if(radio_2 != 1){
		document.getElementById('2g_radio_hint').style.display ="";
	}
	if(radio_5 != 1){
		document.getElementById('5g_radio_hint').style.display ="";
	}

	if(document.form.preferred_lang.value == "JP"){    //use unique font-family for JP
		document.getElementById('2g_radio_hint').style.fontFamily = "MS UI Gothic,MS P Gothic";
		document.getElementById('5g_radio_hint').style.fontFamily = "MS UI Gothic,MS P Gothic";
	}
	
	if("<% get_parameter("af"); %>" == "wl_NOnly_note"){
		var childsel=document.createElement("div");
		childsel.setAttribute("id","wl_NOnly_note");
		childsel.style.color="#FFCC00";
		document.getElementById('gn_desc').parentNode.appendChild(childsel);
		document.getElementById("wl_NOnly_note").innerHTML="* Please change the guest network authentication to WPA2 Personal AES.";	
	}

	showWLMACList();	
}

function change_wl_expire_radio(){
	if(document.form.wl_expire.value > 0){
		document.form.wl_expire_hr.value = Math.floor(document.form.wl_expire.value/3600);
		document.form.wl_expire_min.value  = Math.floor((document.form.wl_expire.value%3600)/60);
		document.form.wl_expire_radio[0].checked = 1;
		document.form.wl_expire_radio[1].checked = 0;
	}
	else{
		document.form.wl_expire_radio[0].checked = 0;
		document.form.wl_expire_radio[1].checked = 1;
	}
}

function translate_auth(flag){
	if(flag == "OPEN")
		return "Open System";
	else if(flag == "SHARED")
		return "Shared Key";
	else if(flag == "WPAPSK")
		return "WPA-Personal";
	else if(flag == "WPA2PSK")
 		return "WPA2-Personal";
	else if(flag == "WPAPSKWPA2PSK")
		return "WPA-Auto-Personal";
	else
		return "unknown Auth";
}

function goToACLFilter(){
if('<% tcWebApi_get("WLan_Common","wl_unit","s"); %>' == '0')
	window.location = "Advanced_ACL_Content.asp?af=wl_maclist_x_0&refresh=2";
else
	window.location = "Advanced_ACL_Content.asp?af=wl_maclist_x_0&refresh=5";
}

function gen_gntable_tr(unit, gn_array, slicesb){
	var GN_band = "";
	var htmlcode = "";
	if(unit == 0) GN_band = 2;
	if(unit == 1) GN_band = 5;
	
	htmlcode += '<table align="left" style="margin:auto;margin-left:20px;border-collapse:collapse;width:720px;';
	if(slicesb > 0)
		htmlcode += 'margin-top:20px;';	
	htmlcode += '"><tr><th align="left" style="width:160px;">';
	htmlcode += '<table id="GNW_'+GN_band+'G" class="gninfo_th_table" align="left" style="margin:auto;border-collapse:collapse;">';
	htmlcode += '<tr><th align="left" style="height:40px;"><% tcWebApi_Get("String_Entry", "QIS_finish_wireless_item1", "s") %></th></tr>';
	htmlcode += "<tr><th align=\"left\" style=\"height:40px;\"><% tcWebApi_Get("String_Entry", "WC11b_AuthenticationMethod_in", "s") %></th></tr>";
	htmlcode += '<tr><th align="left" style="height:40px;"><% tcWebApi_Get("String_Entry", "Network_key", "s") %></th></tr>';
	htmlcode += '<tr><th align="left" style="height:40px;"><% tcWebApi_Get("String_Entry", "mssid_time_remaining", "s") %></th></tr>';
	//DSL-N66U seems workless for this option Access Intranet
	if(sw_mode != "3"){
			htmlcode += '<tr><th align="left" style="width:20%;height:28px;"><% tcWebApi_Get("String_Entry", "Access_Intranet", "s") %></th></tr>';
	}
	htmlcode += '<tr><th align="left" style="height:40px;"></th></tr>';
	htmlcode += '</table></th>';
	
	var gn_array_length = gn_array.length;
	for(var i=0; i<gn_array_length; i++){
			var subunit = i+1+slicesb*4;
			htmlcode += '<td style="padding-right:30px"><table id="GNW_'+GN_band+'G'+i+'" class="gninfo_table" align="center" style="margin:auto;border-collapse:collapse;">';
			if(gn_array[i][0] == "1"){
					htmlcode += '<tr><td align="center" class="gninfo_table_top"></td></tr>';
					show_str = decodeURIComponent(gn_array[i][1]);
					if(show_str.length >= 21)
						show_str = show_str.substring(0,17) + "...";
					show_str = handle_show_str(show_str);	
					htmlcode += '<tr><td align="center" onclick="change_guest_unit('+ unit +','+ subunit +');">'+ show_str +'</td></tr>';
					htmlcode += '<tr><td align="center" onclick="change_guest_unit('+ unit +','+ subunit +');">'+ translate_auth(gn_array[i][2]) +'</td></tr>';
					
					if(gn_array[i][2].indexOf("wpa") >= 0 || gn_array[i][2].indexOf("radius") >= 0)
							show_str = "";					
					else if(gn_array[i][2].indexOf("PSK") >= 0)
							show_str = gn_array[i][4];
					else if(gn_array[i][2] == "OPEN" && gn_array[i][5] == "0")
							show_str = "None";
					else{
							var key_index = parseInt(gn_array[i][6])+6;
							show_str = gn_array[i][key_index];													
					}
					
					show_str = decodeURIComponent(show_str);
					if(show_str.length >= 21)
						show_str = show_str.substring(0,17) + "...";
					show_str = handle_show_str(show_str);
					if(show_str.length <= 0)
						show_str = "&nbsp; ";
					htmlcode += '<tr><td align="center" onclick="change_guest_unit('+ unit +','+ subunit +');">'+ show_str +'</td></tr>';

					if(gn_array[i][11] == 0)
							htmlcode += '<tr><td align="center" onclick="change_guest_unit('+ unit +','+ subunit +');"><% tcWebApi_Get("String_Entry", "Limitless", "s") %></td></tr>';
					else{
							var expire_hr = Math.floor(gn_array[i][13]/3600);
							var expire_min = Math.floor((gn_array[i][13]%3600)/60);
							if(expire_hr > 0)
									htmlcode += '<tr><td align="center" onclick="change_guest_unit('+ unit +','+ subunit +');"><b id="expire_hr_'+i+'">'+ expire_hr + '</b><% tcWebApi_Get("String_Entry", "Hour", "s") %> <b id="expire_min_'+i+'">' + expire_min +'</b> <% tcWebApi_Get("String_Entry", "Minute", "s") %></td></tr>';
							else{
									if(expire_min > 0)
											htmlcode += '<tr><td align="center" onclick="change_guest_unit('+ unit +','+ subunit +');"><b id="expire_min_'+i+'">' + expire_min +'</b> <% tcWebApi_Get("String_Entry", "Minute", "s") %></td></tr>';
									else
											htmlcode += '<tr><td align="center" onclick="change_guest_unit('+ unit +','+ subunit +');"><b id="expire_min_'+i+'">< 1</b> <% tcWebApi_Get("String_Entry", "Minute", "s") %></td></tr>';
							}
					}

			}else{
					htmlcode += '<tfoot><tr rowspan="3"><td align="center"><input type="button" class="button_gen" value="<% tcWebApi_Get("String_Entry", "WC11b_WirelessCtrl_button1name", "s") %>" onclick="create_guest_unit('+ unit +','+ subunit +');"></td></tr></tfoot>';
			}

			//DSL-N66U seems workless for this option Access Intranet
			if(sw_mode != "3"){
					if(gn_array[i][0] == "1")
							htmlcode += '<tr><td align="center" onclick="change_guest_unit('+ unit +','+ subunit +');">'+ gn_array[i][12] +'</td></tr>';
			}

			if(gn_array[i][0] == "1"){
					htmlcode += '<tr><td align="center" class="gninfo_table_bottom"></td></tr>';
					htmlcode += '<tfoot><tr><td align="center"><input type="button" class="button_gen" value="<% tcWebApi_Get("String_Entry", "WC11b_WirelessCtrl_buttonname", "s") %>" onclick="close_guest_unit('+ unit +','+ subunit +');"></td></tr></tfoot>';
			}
			htmlcode += '</table></td>';
	}

	htmlcode += '</tr></table>';

	return htmlcode;
}

function _change_wl_unit_status(__unit){
	document.titleForm.current_page.value = "Advanced_WAdvanced_Content.asp?af=wl_radio";
	document.titleForm.next_page.value = "Advanced_WAdvanced_Content.asp?af=wl_radio";
	change_wl_unit_status(__unit);
}

function gen_gntable(){
	var htmlcode = "";
	var htmlcode5 = "";
	var gn_array_2g_tmp = gn_array_2g;
	var gn_array_5g_tmp = gn_array_5g;
	var band2sb = 0;
	var band5sb = 0;
	
	htmlcode += '<table style="margin-left:20px;margin-top:25px;" width="95%" align="center" cellpadding="4" cellspacing="0" class="gninfo_head_table" id="gninfo_table_2g">';
	htmlcode += '<tr id="2g_title"><td align="left" style="color:#5AD;font-size:16px; border-bottom:1px dashed #AAA;"><span>2.4GHz</span>';
	htmlcode += '<span id="2g_radio_hint" style="font-size: 14px;display:none;color:#FC0;margin-left:17px;">* <%tcWebApi_get("String_Entry","GuestNetwork_Radio_Status","s") %> <a style="font-family:Lucida Console;color:#FC0;text-decoration:underline;cursor:pointer;" onclick="_change_wl_unit_status(0);"><%tcWebApi_get("String_Entry","btn_go","s")%></a></span></td></tr>';
	htmlcode += '<tr><td>';
	htmlcode += gen_gntable_tr(0, gn_array_2g_tmp, band2sb);
	htmlcode += '</td></tr>';
	htmlcode += '</table>';
	document.getElementById("guest_table2").innerHTML = htmlcode;

	htmlcode5 += '<br><table style="margin-left:20px;margin-top:35px;" width="95%" align="center" cellpadding="4" cellspacing="0" class="gninfo_head_table" id="gninfo_table_5g">';
	htmlcode5 += '<tr id="5g_title"><td align="left" style="color:#5AD; font-size:16px; border-bottom:1px dashed #AAA;"><span>5GHz</span><td><tr>';
	htmlcode5 += '<span id="5g_radio_hint" style="font-size: 14px;display:none;color:#FC0;margin-left:17px;">* <%tcWebApi_get("String_Entry","GuestNetwork_Radio_Status","s") %> <a style="font-family:Lucida Console;color:#FC0;text-decoration:underline;cursor:pointer;" onclick="_change_wl_unit_status(1);"><%tcWebApi_get("String_Entry","btn_go","s")%></a></span></td></tr>';
	htmlcode5 += '<tr><td>';
	htmlcode5 += gen_gntable_tr(1, gn_array_5g_tmp, band5sb);
	htmlcode5 += '</td></tr>';
	htmlcode5 += '</table>';	
	document.getElementById("guest_table5").innerHTML = htmlcode5;	
}

function add_options_value(o, arr, orig){
	if(orig == arr)
		add_option(o, "mbss_"+arr, arr, 1);
	else
		add_option(o, "mbss_"+arr, arr, 0);
}

function redirect(){
	document.location.href = "/cgi-bin/Guest_network.asp";
}

//javi
//For using the format of ASUS WRT, we follow the JAVA script.
//However, the parameter wl_auth_mode_x has many JAVA code in general.js, it is default to change the value of option type.
//We must add the function to translate the value of parameters between ASUS WRT and RT-65168.
function TranslateWRTtoMTK(){
	var auth_mode = document.form.wl_auth_mode_x.value;
	if(auth_mode == "open")
		document.form.wl_auth_mode_save.value = "OPEN";
	else if(auth_mode == "shared")
		document.form.wl_auth_mode_save.value = "SHARED";
	else if(auth_mode == "psk")
		document.form.wl_auth_mode_save.value = "WPAPSK";
	else if(auth_mode == "psk2")
		document.form.wl_auth_mode_save.value = "WPA2PSK";
	else if(auth_mode == "pskpsk2")
		document.form.wl_auth_mode_save.value = "WPAPSKWPA2PSK";
	else if(auth_mode == "wpa")
		document.form.wl_auth_mode_save.value = "WPA";
	else if(auth_mode == "wpa2")
		document.form.wl_auth_mode_save.value = "WPA2";
	else if(auth_mode == "wpawpa2")
		document.form.wl_auth_mode_save.value = "WPA1WPA2";
	else if(auth_mode == "radius")
		document.form.wl_auth_mode_save.value = "Radius";
	else
		document.form.wl_auth_mode_save.value = "OPEN";

	if(auth_mode == "open" || auth_mode == "")	//avoid to misunderstand that had been encrypt.
		document.form.wl_crypto_save.value = "NONE";
	else
		document.form.wl_crypto_save.value = document.form.wl_crypto.value;
}

function TranslateWRTtoMTK_auth_mode(term){
	if(term == "OPEN")
		return "open";
	else if(term == "SHARED")
		return "shared";
	else if(term == "WPAPSK")
		return "psk";
	else if(term == "WPA2PSK")
		return "psk2";
	else if(term == "WPAPSKWPA2PSK")
		return "pskpsk2";
	else if(term == "WPA")
		return "wpa";
	else if(term == "WPA2")
		return "wpa2";
	else if(term == "WPA1WPA2")
		return "wpawpa2";
	else if(term == "Radius")
		return "radius";			
}

function applyRule(){	
	if(validForm()){
		updateMacList();
		inputCtrl(document.form.wl_crypto, 1);
		inputCtrl(document.form.wl_wpa_psk, 1);
		inputCtrl(document.form.wl_wep_x, 1);
		inputCtrl(document.form.wl_key, 1);
		inputCtrl(document.form.wl_key1, 1);
		inputCtrl(document.form.wl_key2, 1);
		inputCtrl(document.form.wl_key3, 1);
		inputCtrl(document.form.wl_key4, 1);
		inputCtrl(document.form.wl_phrase_x, 1);

		if(document.form.wl_expire_radio[0].checked)
			document.form.wl_expire.value = document.form.wl_expire_hr.value*3600 + document.form.wl_expire_min.value*60;
		else
			document.form.wl_expire.value = 0;

		TranslateWRTtoMTK();
		if(document.form.wl_unit.value == 1)
			document.form.wl_nmode_orig.value = wl1_nmode_x;
		else
			document.form.wl_nmode_orig.value = wl0_nmode_x;	
				
		document.form.action = "/cgi-bin/Guest_network.asp";
		document.form.editFlag.value = "1" ;
		document.form.MBSSID_able_Flag.value = "0" ;
		document.form.MBSSID_changeFlag.value = "2" ;
		if(model_name == "DSL-N66U")
		{
			showLoading(28);
			setTimeout("redirect();", 28000);
		}
		else
		{
			showLoading(28);//23
			setTimeout("redirect();", 28000);
		}
		if(navigator.appName.indexOf("Microsoft") >= 0){ 		// Jieming added at 2013/05/21, to avoid browser freeze when submitting form on IE
			stopFlag = 1;
		}		
		
		en_dis_guest_unit(document.form.wl_unit.value, document.form.wl_subunit.value, "1");
		document.form.submit();
	}
}

function validForm(){
	var auth_mode = document.form.wl_auth_mode_x.value;

	if(!validate_string_ssid(document.form.wl_ssid))
		return false;

	if(document.form.wl_wep_x.value != "0")
		if(!validate_wlphrase('WLANConfig11b', 'wl_phrase_x', document.form.wl_phrase_x))
			return false;
	if(auth_mode == "psk" || auth_mode == "psk2" || auth_mode == "pskpsk2"){
		if(!validate_psk(document.form.wl_wpa_psk))
			return false;
		//confirm common string combination     #JS_common_passwd#
			var is_common_string = check_common_string(document.form.wl_wpa_psk.value, "wpa_key");
			if(is_common_string){
				if(confirm("<% tcWebApi_Get("String_Entry", "JS_common_passwd","s") %>")){
					document.form.wl_wpa_psk.focus();
					document.form.wl_wpa_psk.select();
					return false;   
				}       
			}
	}
	else{
		var cur_wep_key = eval('document.form.wl_key'+document.form.wl_key.value);
		if(auth_mode != "radius" && !validate_wlkey(cur_wep_key))
			return false;
	}
	return true;
}

function done_validating(action){
	refreshpage();
}

function change_key_des(){
	var objs = getElementsByName_iefix("span", "key_des");
	var wep_type = document.form.wl_wep_x.value;
	var str = "";
	if(wep_type == "1")
		str = "(<%tcWebApi_get("String_Entry","WC11b_WEPKey_itemtype1","s")%>)";
	else if(wep_type == "2")
		str = "(<%tcWebApi_get("String_Entry","WC11b_WEPKey_itemtype2","s")%>)";
	
	for(var i = 0; i < objs.length; ++i)
		showtext(objs[i], str);
} 

function validate_wlphrase(s, v, obj){
	if(!validate_string(obj)){
		is_wlphrase(s, v, obj);
		return(false);
	}

	return true;
}

function disableAdvFn(){
	for(var i=16; i>=1; i--)
		$("WLgeneral").deleteRow(i);
}

function guest_divctrl(flag){
	if(flag == 1){
		document.getElementById("guest_table2").style.display = "none";
		if(band5g_support != -1)
			document.getElementById("guest_table5").style.display = "none";
			
		document.getElementById("gnset_table").style.display = "";
		//DSL-N66U seems workless for this option Access Intranet 
		if(sw_mode == "3")
				inputCtrl(document.form.wl_lanaccess, 0);
				
		document.getElementById("applyButton").style.display = "";				
	}
	else{
		document.getElementById("guest_table2").style.display = "";
		if(band5g_support == -1 || no5gmssid_support != -1)
				document.getElementById("guest_table5").style.display = "none";
		else
				document.getElementById("guest_table5").style.display = "";
				
		document.getElementById("gnset_table").style.display = "none";
		document.getElementById("applyButton").style.display = "none";
		document.getElementById("maclistMain").style.display = "none";
	}
}

function mbss_display_ctrl(){
	// generate options
	if(multissid_support){		
		document.getElementById("wl_channel_field").style.display = "none";
		document.getElementById("wl_nctrlsb_field").style.display = "none";
			for(var i=1; i<multissid_support+1; i++){
				add_options_value(document.form.wl_subunit, i, '<% tcWebApi_get("WLan_Common","wl_subunit","s"); %>');
			}
	}
	else{
		document.getElementById("gnset_table").style.display = "none";
		document.getElementById("guest_table2").style.display = "none";
		if(band5g_support != -1)
			document.getElementById("guest_table5").style.display = "none";
			
		document.getElementById("applyButton").style.display = "none";
		document.getElementById("applyButton").innerHTML = "Not support!";
		document.getElementById("applyButton").style.fontSize = "25px";
		document.getElementById("applyButton").style.marginTop = "125px";
	}
}

function en_dis_guest_unit(_unit, _subunit, _setting){
	var NewInput = document.createElement("input");
	NewInput.type = "hidden";
	NewInput.name = "wl"+ _unit + "." + _subunit +"_bss_enabled";
	NewInput.value = _setting;
	document.form.appendChild(NewInput);
	document.form.wl_unit.value = _unit;
	document.form.wl_subunit.value = _subunit;	
	//document.form.submit();
}

function close_guest_unit(_unit, _subunit){
	var NewInput = document.createElement("input");
	NewInput.type = "hidden";
	NewInput.name = "wl"+ _unit + "." + _subunit +"_bss_enabled";
	NewInput.value = "0";
	document.form.appendChild(NewInput);
	document.form.wl_unit.value = _unit;
	document.form.wl_subunit.value = _subunit;
	document.form.action = "/cgi-bin/Guest_network.asp";
	document.form.editFlag.value = "1" ;
	document.form.MBSSID_able_Flag.value = "1" ;
	showLoading(4);
	setTimeout("redirect();", 4000);
	document.form.submit();
}

var edit_unit = "";
function change_guest_unit(_unit, _subunit){	
	var idx;
	switch(_unit){
		case 0:
			edit_unit=0;
			gn_array = gn_array_2g;
			document.form.wl_nmode_x.value = wl0_nmode_x;
			break;
		case 1:			
			edit_unit=1;
			gn_array = gn_array_5g;
			document.form.wl_nmode_x.value = wl1_nmode_x;
			break;
		default:
			break;
	}	
	idx = _subunit - 1;
	GN_limit_auth_method();	//use this OK ? Viz
	//limit_auth_method(_unit);	
	
	document.form.wl_unit.value = _unit;
	document.form.wl_subunit.value = _subunit;
	document.getElementById("wl_vifname").innerHTML = document.form.wl_subunit.value;
	document.form.wl_bss_enabled.value = decodeURIComponent(gn_array[idx][0]);
	document.form.wl_ssid.value = decodeURIComponent(gn_array[idx][1]);
	
	var wl_auth_mode_value = TranslateWRTtoMTK_auth_mode(decodeURIComponent(gn_array[idx][2]));
	document.form.wl_auth_mode_x.value = wl_auth_mode_value;	
	wl_auth_mode_change(1);
	document.form.wl_crypto.value = decodeURIComponent(gn_array[idx][3]);		
	document.form.wl_wpa_psk.value = decodeURIComponent(gn_array[idx][4]);
	document.form.wl_wep_x.value = decodeURIComponent(gn_array[idx][5]);
	document.form.wl_key.value = decodeURIComponent(gn_array[idx][6]);
	document.form.wl_key1.value = decodeURIComponent(gn_array[idx][7]);
	document.form.wl_key2.value = decodeURIComponent(gn_array[idx][8]);
	document.form.wl_key3.value = decodeURIComponent(gn_array[idx][9]);
	document.form.wl_key4.value = decodeURIComponent(gn_array[idx][10]);
	document.form.wl_phrase_x.value = decodeURIComponent(gn_array[idx][17]);
	document.form.wl_expire.value = decodeURIComponent(gn_array[idx][11]);
	document.form.wl_lanaccess.value = decodeURIComponent(gn_array[idx][12]);	
	
	wl_wep_change(_unit);
	change_wl_expire_radio();
	guest_divctrl(1);
	
	updateMacModeOption();
}

function create_guest_unit(_unit, _subunit){	
	switch(_unit){
		case 0:
			gn_array = gn_array_2g;
			break;
		case 1:
			gn_array = gn_array_5g;
			break;
		default:
			break;			
	}
	
	if(gn_array[_subunit-1][15] != "1"){
		change_guest_unit(_unit, _subunit);
		document.form.wl_bss_enabled.value = "1";
	}else{
		en_dis_guest_unit(_unit, _subunit, "1");
	}
	
}

// mac filter
function updateMacModeOption(){
	wl_maclist_x_array = decodeURIComponent(gn_array[document.form.wl_subunit.value-1][16]).replace(/&#60/g, "<");
	var wl_maclist_x_row = wl_maclist_x_array.split('<');
	var clientName = "New device";
	manually_maclist_list_array = [];
	for(var i = 1; i < wl_maclist_x_row.length; i++) {
		if(clientList[wl_maclist_x_row[i]]) {
			clientName = clientList[wl_maclist_x_row[i]].Name;
		}
		else {
			clientName = "New device";
		}
		manually_maclist_list_array[wl_maclist_x_row[i]] = clientName;
	}
	show_wl_maclist_x();

	document.form.wl_macmode.value = gn_array[document.form.wl_subunit.value-1][14];	
	document.form.wl_maclist.value = decodeURIComponent(gn_array[document.form.wl_subunit.value-1][16]).replace(/&#60/g, "<");
	document.getElementById("maclistMain").style.display = (gn_array[document.form.wl_subunit.value-1][14] == "disabled") ? "none" : "";
}

function show_wl_maclist_x(){
	var code = "";
	code +='<table width="80%" border="1" cellspacing="0" cellpadding="4" align="center" class="list_table" id="wl_maclist_x_table">'; 
	document.form.wl_maclist.value = "";
	if(Object.keys(manually_maclist_list_array).length == 0)
		code +='<tr><td style="color:#FFCC00;"><%tcWebApi_get("String_Entry","IPC_VSList_Norule","s")%></td>';
	else{
		//user icon
		//var userIconBase64 = "NoIcon";
		var clientName, deviceType, deviceVender;
		var count=0;
		Object.keys(manually_maclist_list_array).forEach(function(key) {
			var clientMac = key;
			if(clientList[clientMac]) {
				clientName = clientList[clientMac].Name;
				deviceType = clientList[clientMac].type;
				//deviceVender = clientList[clientMac].dpiVender;
			}
			else {
				clientName = "New device";
				deviceType = 0;
				//deviceVender = "";
			}
			code +='<tr id="row_'+clientMac+'">';
			code +='<td width="80%" align="center">';
			code += '<table style="width:100%;"><tr>';
			//Icon removed
			code += '<td style="border:0px; text-align:center;">';
			code += '<div>' + clientName + '</div>';
			code += '<div>' + clientMac + '</div>';
			code += '</td></tr></table>';
			code += '</td>';
			code +='<td width="20%"><input type="button" class=\"remove_btn\" onclick=\"deleteRow(this, \'' + clientMac + '\');\" value=\"\"/></td></tr>';
			if(count>0) 
				document.form.wl_maclist.value += "<";
			document.form.wl_maclist.value += clientMac;
			count++;
		});
	}	
	
  	code +='</tr></table>';
	document.getElementById("wl_maclist_x_Block").innerHTML = code;
}

function deleteRow(r, delMac){
	var i = r.parentNode.parentNode.rowIndex;
	delete manually_maclist_list_array[delMac];
	document.getElementById('wl_maclist_x_table').deleteRow(i);

	if(Object.keys(manually_maclist_list_array).length == 0)
		show_wl_maclist_x();
}

function addRow(obj, upper){
	var rule_num = document.getElementById('wl_maclist_x_table').rows.length;
	var item_num = document.getElementById('wl_maclist_x_table').rows[0].cells.length;
	var mac = obj.value.toUpperCase();

	if(rule_num >= upper){
		alert("<%tcWebApi_get("String_Entry","JS_itemlimit1","s")%> " + upper + " <%tcWebApi_get("String_Entry","JS_itemlimit2","s")%>");
		return false;	
	}	
	
	if(mac==""){
		alert("<%tcWebApi_get("String_Entry","JS_fieldblank","s")%>");
		obj.focus();
		obj.select();			
		return false;
	}else if(!check_macaddr(obj, check_hwaddr_flag(obj))){
		obj.focus();
		obj.select();	
		return false;	
	}
		
		//Viz check same rule
	for(i=0; i<rule_num; i++){
		for(j=0; j<item_num-1; j++){	
			if(manually_maclist_list_array[mac] != null){
				alert("<%tcWebApi_get("String_Entry","JS_duplicate","s")%>");
				return false;
			}	
		}		
	}		
	
	if(clientList[mac]) {
		manually_maclist_list_array[mac] = (clientList[mac].nickName == "") ? clientList[mac].name : clientList[mac].nickName;
	}
	else {
		manually_maclist_list_array[mac] = "New device";
	}

	obj.value = ""
	show_wl_maclist_x();
}

function updateMacList(){
	var rule_num = document.getElementById('wl_maclist_x_table').rows.length;
	var item_num = document.getElementById('wl_maclist_x_table').rows[0].cells.length;
	var tmp_value = "";

	Object.keys(manually_maclist_list_array).forEach(function(key) {
		tmp_value += "<" + key;
	});

	if(tmp_value == "<"+"<%tcWebApi_get("String_Entry","IPC_VSList_Norule","s")%>" || tmp_value == "<")
		tmp_value = "";	

	document.form.wl_maclist.value = tmp_value;
}

function check_macaddr(obj,flag){ //control hint of input mac address
	if(flag == 1){
		var childsel=document.createElement("div");
		childsel.setAttribute("id","check_mac");
		childsel.style.color="#FFCC00";
		obj.parentNode.appendChild(childsel);
		document.getElementById("check_mac").innerHTML="<%tcWebApi_get("String_Entry","LHC_MnlDHCPMacaddr_id","s")%>";		
		document.getElementById("check_mac").style.display = "";
		return false;
	}else if(flag ==2){
		var childsel=document.createElement("div");
		childsel.setAttribute("id","check_mac");
		childsel.style.color="#FFCC00";
		obj.parentNode.appendChild(childsel);
		document.getElementById("check_mac").innerHTML="<%tcWebApi_get("String_Entry","IPC_x_illegal_mac","s")%>";
		document.getElementById("check_mac").style.display = "";
		return false;		
	}else{	
		document.getElementById("check_mac") ? document.getElementById("check_mac").style.display="none" : true;
		return true;
	}	
}

var isMenuopen = 0;
function pullWLMACList(obj){	//Viz here 2015/10/23
	if(isMenuopen == 0){		
		obj.src = "/images/arrow-top.gif"
		document.getElementById("WL_MAC_List_Block").style.display = "block";
		document.form.wl_maclist_x_0.focus();		
		isMenuopen = 1;
	}
	else
		hideClients_Block();
}

function hideClients_Block(){
	document.getElementById("pull_arrow").src = "/images/arrow-down.gif";
	document.getElementById("WL_MAC_List_Block").style.display="none";
	isMenuopen = 0;
}

var over_var = 0;
function showWLMACList(){
	if(clientList.length == 0){
		setTimeout(function() {
			genClientList();
			showWLMACList();
		}, 500);
		return false;
	}
	
	var code = "";
	var show_macaddr = "";
	var wireless_flag = 0;
	for(i=0;i<clientList.length;i++){		
		if(clientList[clientList[i]].isWL != 0){		//0: wired, 1: 2.4GHz, 2: 5GHz, filter clients under current band
			wireless_flag = 1;
			var clientName = clientList[clientList[i]].Name;
			code += '<a title=' + clientList[i] + '><div onmouseover="over_var=1;" onmouseout="over_var=0;" onclick="setClientmac(\''+clientList[i]+'\');"><strong>' + clientName + '</strong> ';
			code += ' </div></a>';
		}
	}
			
	code +='<!--[if lte IE 6.5]><iframe class="hackiframe2"></iframe><![endif]-->';	
	document.getElementById("WL_MAC_List_Block").innerHTML = code;
	
	if(wireless_flag == 0)
		document.getElementById("pull_arrow").style.display = "none";
	else
		document.getElementById("pull_arrow").style.display = "";
}

function setClientmac(macaddr){
	document.form.wl_maclist_x_0.value = macaddr;
	hideClients_Block();
	over_var = 0;
}

function maclistMain_display(obj){	
	document.getElementById("maclistMain").style.display = (obj.value == "disabled") ? "none" : "";
}
</script>
</head>

<body onload="initial();">
<div id="TopBanner"></div>
<div id="Loading" class="popup_bg"></div>
<div id="hiddenMask" class="popup_bg">
	<table cellpadding="4" cellspacing="0" id="dr_sweet_advise" class="dr_sweet_advise" align="center">
		<tr>
		<td>
			<div class="drword" id="drword"><%tcWebApi_get("String_Entry","Main_alert_proceeding_desc4","s")%> <%tcWebApi_get("String_Entry","Main_alert_proceeding_desc1","s")%>...
				<br/>
				<br/>
		    </div>
		  <div class="drImg"><img src="/images/alertImg.png"></div>
			<div style="height:70px; "></div>
		</td>
		</tr>
	</table>
<!--[if lte IE 6.5]><iframe class="hackiframe"></iframe><![endif]-->
</div>
<iframe name="hidden_frame" id="hidden_frame" width="0" height="0" frameborder="0"></iframe>
<form method="post" name="unitform" action="Guest_network.asp" target="hidden_frame">
<input type="hidden" name="changeflag" value="0">
<input type="hidden" name="current_page" value="Guest_network.asp">
<input type="hidden" name="next_page" value="Guest_network.asp">
<input type="hidden" name="action_mode" value="apply">
<input type="hidden" name="action_script" value="restart_wireless">
<input type="hidden" name="action_wait" value="8">
</form>
<form method="post" name="form" action="Guest_network.asp" target="hidden_frame">
<input type="hidden" name="productid" value="<% tcWebApi_staticGet("SysInfo_Entry","ProductName","s") %>">
<input type="hidden" name="wan_route_x" value="">
<input type="hidden" name="wan_nat_x" value="1">
<input type="hidden" name="current_page" value="Guest_network.asp">
<input type="hidden" name="next_page" value="Guest_network.asp">
<input type="hidden" name="next_host" value="">
<input type="hidden" name="modified" value="0">
<input type="hidden" name="action_mode" value="apply">
<input type="hidden" name="action_script" value="restart_wireless">
<input type="hidden" name="action_wait" value="8">
<input type="hidden" name="preferred_lang" id="preferred_lang" value="EN">
<input type="hidden" name="wl_country_code" value="TW" disabled>
<input type="hidden" name="firmver" value="<% tcWebApi_staticGet("DeviceInfo","FwVer","s") %>">
<input type="hidden" name="wl_ssid_org" value="ASUS%5FGuest1">
<input type="hidden" name="wl_nmode_orig" value="">
<input type="hidden" name="wl_wpa_psk_org" value="">
<input type="hidden" name="x_RegulatoryDomain" value="" readonly="1">
<input type="hidden" name="wl_wme" value="on">
<input type="hidden" name="wl_nctrlsb_old" value="1">
<input type="hidden" name="wl_key_type" value='1'>
<input type="hidden" name="wl_channel_orig" value='<% tcWebApi_get("WLan_Common","Channel","s"); %>'>
<input type="hidden" name="wl_expire" value='<% tcWebApi_get("WLan_Entry","expire","s"); %>'>
<input type="hidden" name="wl_maclist" value="<% tcWebApi_get("ACL_Entry0","wl_maclist","s"); %>">
<input type="hidden" name="wl_gmode_protection" value="auto" disabled>
<input type="hidden" name="wl_wpa_mode" value="0" disabled>
<input type="hidden" name="wl_mode_x" value="0" disabled>
<input type="hidden" name="flag" value="0">
<input type="hidden" name="editFlag" value="0">
<input type="hidden" name="wl_auth_mode_save" value="OPEN">
<input type="hidden" name="wl_crypto_save" value="NONE">
<input type="hidden" name="MBSSID_changeFlag" value="1">
<input type="hidden" name="MBSSID_able_Flag" value="0">
<input type="hidden" name="w_Setting" value="1">
<select name="wl_subunit" class="input_option" onChange="change_wl_unit();" style="display:none"></select>

<table class="content" align="center" cellpadding="0" cellspacing="0">
  <tr>
	<td width="17">&nbsp;</td>

	<!--=====Beginning of Main Menu=====-->
	<td valign="top" width="202">
	  <div id="mainMenu"></div>
	  <div id="subMenu"></div>
	</td>

	<td height="380" valign="top">
	  <div id="tabMenu" class="submenuBlock" style="*margin-top:-155px;"></div>

<!--===================================Beginning of Main Content===========================================-->
<table width="98%" border="0" align="left" cellpadding="0" cellspacing="0">
  <tr>
	<td align="left" valign="top" >
	  <table width="760px" border="0" cellpadding="4" cellspacing="0" class="FormTitle" style="margin-top:5px;-webkit-border-radius:3px;-moz-border-radius:3px;border-radius:3px;" id="FormTitle">
		<tbody>
		<tr>
		  <td bgcolor="#4D595D" valign="top" id="table_height"  >
		  <div>&nbsp;</div>

		  <div class="formfonttitle"><%tcWebApi_get("String_Entry","Guest_Network","s")%></div>
	    <div style="margin-left:5px;margin-top:10px;margin-bottom:10px"><img src="/images/New_ui/export/line_export.png"></div>

			<div>
				<table width="650px" style="margin:25px;">
					<tr>
						<td width="120px">
							<img id="guest_image" src="/images/New_ui/network_config.png">
						</td>
						<td>
							<div class="formfontdesc" style="font-style: italic;font-size: 14px;"><%tcWebApi_get("String_Entry","GuestNetwork_desc","s")%></div>

						</td>
					</tr>
				</table>
			</div>

			<!-- info table -->
			<div id="guest_table2"></div>
			<div id="guest_table5"></div>

			<!-- setting table -->
			<table width="80%" border="1" align="center" style="margin-top:10px;margin-bottom:20px;" cellpadding="4" cellspacing="0" id="gnset_table" class="FormTable">
				<tr id="wl_unit_field" style="display:none">
					<th><%tcWebApi_get("String_Entry","Interface","s")%></th>
					<td>
						<select name="wl_unit" class="input_option" onChange="change_wl_unit();" style="display:none">
							<option class="content_input_fd" value="0" <% if tcWebApi_get("WLan_Common","wl_unit","h") = "0" then asp_Write("selected") end if %>>2.4GHz</option>
							<option class="content_input_fd" value="1" <% if tcWebApi_get("WLan_Common","wl_unit","h") = "1" then asp_Write("selected") end if %>>5GHz</option>
						</select>
						<p id="wl_ifname">2.4GHz</p>
					</td>
				</tr>

				<tr style="display:none">
					<td>
						<!-- Multiple BSSID does not support this.-->
						<span><span><input type="hidden" name="wl_wpa_gtk_rekey" value="0" disabled></span></span>
					</td>
				</tr>

				<tr>
					<th><%tcWebApi_get("String_Entry","Guest_network_index","s")%></th>
					<td>
						<p id="wl_vifname"></p>
					</td>
				</tr>

				<tr style="display:none">
					<th><%tcWebApi_get("String_Entry","Guest_Network_enable","s")%></th>
					<td>
						<select id="wl_bss_enabled_field" name="wl_bss_enabled" class="input_option">
							<option class="content_input_fd" value="0" <% if tcWebApi_get("WLan_Entry","bss_enabled","h") = "0" then asp_Write("checked") end if %>><%tcWebApi_get("String_Entry","checkbox_No","s")%></option>
							<option class="content_input_fd" value="1" <% if tcWebApi_get("WLan_Entry","bss_enabled","h") = "1" then asp_Write("checked") end if %>><%tcWebApi_get("String_Entry","checkbox_Yes","s")%></option>
						</select>
					</td>
				</tr>

				<tr>
					<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 1);"><% tcWebApi_Get("String_Entry", "QIS_finish_wireless_item1", "s") %></a></th>
					<td>
						<input type="text" maxlength="32" class="input_32_table" name="wl_ssid" value="<% If tcWebApi_get("WLan_Entry","ssid","h") <> "" then  tcWebApi_get("WLan_Entry","ssid","s") else asp_Write("ASUS_VSL_N66U") end if %>" onkeypress="return is_string(this, event)">
					</td>
				</tr>

				<!-- Hidden and disable item, start -->
			  <tr style="display:none">
					<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 4);"><%tcWebApi_get("String_Entry","WC11b_x_Mode11g_in","s")%></a></th>
					<td>
						<select name="wl_nmode_x" class="input_option" onChange="return change_common(this, 'WLANConfig11b', 'wl_nmode_x');" disabled>
							<option value="9">Auto</option>
							<option value="6">N Only</option>
							<option value="0">Legacy</option>
						</select>
						<input type="checkbox" name="wl_gmode_check" id="wl_gmode_check" value="" onClick="return change_common(this, 'WLANConfig11b', 'wl_gmode_check', '1')"> b/g Protection</input>
						<span id="wl_nmode_x_hint" style="display:none"><%tcWebApi_get("String_Entry","WC11n_automode_limition_hint","s")%></span>
					</td>
			  </tr>

				<tr id="wl_channel_field">
					<th><a id="wl_channel_select" class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 3);"><%tcWebApi_get("String_Entry","WC11b_Channel_in","s")%></a></th>
					<td>
				 		<select name="wl_channel" class="input_option" onChange="return change_common(this, 'WLANConfig11b', 'wl_channel')" disabled>
							<option value="0" selected>Auto</option><option value="1" >1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option><option value="6" >6</option><option value="7" >7</option><option value="8" >8</option><option value="9" >9</option><option value="10" >10</option><option value="11" >11</option>
				 		</select>
					</td>
			  </tr>

			 	<tr id="wl_bw_field" style="display:none;">
			   	<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 14);"><%tcWebApi_get("String_Entry","WC11b_ChannelBW_in","s")%></a></th>
			   	<td>
						<select name="wl_bw" class="input_option" onChange="return change_common(this, 'WLANConfig11b', 'wl_bw')" disabled>
							<option class="content_input_fd" value="0" >20 MHz</option>
							<option class="content_input_fd" value="1" selected>20/40 MHz</option>
							<option class="content_input_fd" value="2" >40 MHz</option>
						</select>
			   	</td>
			 	</tr>
				<!-- Hidden and disable item, end -->

			  <tr id="wl_nctrlsb_field">
			  	<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 15);"><%tcWebApi_get("String_Entry","WC11b_EChannel_in","s")%></a></th>
		   		<td>
					<select name="wl_nctrlsb" class="input_option">
						<option value="lower" >lower</option>
						<option value="upper">upper</option>
					</select>
					</td>
		  	</tr>

		  	<tr>
					<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 5);"><%tcWebApi_get("String_Entry","WC11b_AuthenticationMethod_in","s")%></a></th>
					<td>
				  		<select name="wl_auth_mode_x" class="input_option" onChange="authentication_method_change(this, edit_unit);">
								<option value="open">Open System</option>
								<option value="shared">Shared Key</option>
								<option value="psk">WPA-Personal</option>
								<option value="psk2">WPA2-Personal</option>
								<option value="pskpsk2">WPA-Auto-Personal</option>
				  		</select>
					</td>
		  	</tr>

		  	<tr>
					<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 6);"><%tcWebApi_get("String_Entry","WC11b_WPAType_in","s")%></a></th>
					<td>
			  		<select name="wl_crypto" class="input_option" onChange="return change_common(this, 'WLANConfig11b', 'wl_crypto')">
							<option value="AES">AES</option>
							<option value="TKIPAES">TKIP+AES</option>
			  		</select>
					</td>
		  	</tr>

		  	<tr>
					<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 7);"><%tcWebApi_get("String_Entry","WC11b_x_PSKKey_in","s")%></a></th>
					<td>
			  		<input type="password" name="wl_wpa_psk" maxlength="65" class="input_32_table" value="<% If tcWebApi_get("WLan_Entry","wpa_psk","h") <> "" then tcWebApi_get("WLan_Entry","wpa_psk","s") end if %>" onBlur="switchType(this, false);" onFocus="switchType(this, true);">
					</td>
		  	</tr>

		  	<tr>
					<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 9);"><%tcWebApi_get("String_Entry","WC11b_WEPType_in","s")%></a></th>
					<td>
			  		<select name="wl_wep_x" class="input_option" onChange="return change_common(this, 'WLANConfig11b', 'wl_wep_x');">
							<option value="0" <% if tcWebApi_get("WLan_Entry","wep_x","h") = "0" then asp_Write("selected") end if %>><%tcWebApi_get("String_Entry","checkbox_No","s")%></option>
							<option value="1" <% if tcWebApi_get("WLan_Entry","wep_x","h") = "1" then asp_Write("selected") end if %>>WEP-64bits</option>
							<option value="2" <% if tcWebApi_get("WLan_Entry","wep_x","h") = "2" then asp_Write("selected") end if %>>WEP-128bits</option>
			  		</select>
			  		<span name="key_des"></span>
					</td>
		  	</tr>

		  	<tr>
					<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 10);"><%tcWebApi_get("String_Entry","WC11b_WEPDefaultKey_in","s")%></a></th>
					<td>
				 		<select name="wl_key" class="input_option"  onChange="return change_common(this, 'WLANConfig11b', 'wl_key');">
							<option value="1" <% if tcWebApi_get("WLan_Entry","key","h") = "1" then asp_Write("selected") end if %>>1</option>
							<option value="2" <% if tcWebApi_get("WLan_Entry","key","h") = "2" then asp_Write("selected") end if %>>2</option>
							<option value="3" <% if tcWebApi_get("WLan_Entry","key","h") = "3" then asp_Write("selected") end if %>>3</option>
							<option value="4" <% if tcWebApi_get("WLan_Entry","key","h") = "4" then asp_Write("selected") end if %>>4</option>
			  		</select>
					</td>
			 	</tr>

				<tr>
					<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 18);"><%tcWebApi_get("String_Entry","WC11b_WEPKey1_in","s")%></th>
					<td><input type="text" name="wl_key1" id="wl_key1" maxlength="32" class="input_32_table" value="<% If tcWebApi_get("WLan_Entry","key1","h") <> "" then  tcWebApi_get("WLan_Entry","key1","s") end if %>" onKeyUp="return change_wlkey(this, 'WLANConfig11b');"></td>
				</tr>
				<tr>
					<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 18);"><%tcWebApi_get("String_Entry","WC11b_WEPKey2_in","s")%></th>
					<td><input type="text" name="wl_key2" id="wl_key2" maxlength="32" class="input_32_table" value="<% If tcWebApi_get("WLan_Entry","key2","h") <> "" then  tcWebApi_get("WLan_Entry","key2","s") end if %>" onKeyUp="return change_wlkey(this, 'WLANConfig11b');"></td>
				</tr>
				<tr>
					<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 18);"><%tcWebApi_get("String_Entry","WC11b_WEPKey3_in","s")%></th>
					<td><input type="text" name="wl_key3" id="wl_key3" maxlength="32" class="input_32_table" value="<% If tcWebApi_get("WLan_Entry","key3","h") <> "" then  tcWebApi_get("WLan_Entry","key3","s") end if %>" onKeyUp="return change_wlkey(this, 'WLANConfig11b');"></td>
				</tr>
				<tr>
					<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 18);"><%tcWebApi_get("String_Entry","WC11b_WEPKey4_in","s")%></th>
					<td><input type="text" name="wl_key4" id="wl_key4" maxlength="32" class="input_32_table" value="<% If tcWebApi_get("WLan_Entry","key4","h") <> "" then  tcWebApi_get("WLan_Entry","key4","s") end if %>" onKeyUp="return change_wlkey(this, 'WLANConfig11b');"></td>
				</tr>
				<tr style="display:none">
					<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 8);"><%tcWebApi_get("String_Entry","WC11b_x_Phrase_in","s")%></a></th>
					<td>
					<input type="text" name="wl_phrase_x" maxlength="64" class="input_32_table" value="<% If tcWebApi_get("WLan_Entry","phrase_x","h") <> "" then  tcWebApi_get("WLan_Entry","phrase_x","s") end if %>" onKeyUp="return is_wlphrase('WLANConfig11b', 'wl_phrase_x', this);">
					</td>
				</tr>

				<tr>
					<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 25);"><%tcWebApi_get("String_Entry","Access_Time","s")%></a></th>
					<td>
					<input type="radio" value="1" name="wl_expire_radio" class="content_input_fd" onClick="">
					<input type="text" maxlength="2" name="wl_expire_hr" class="input_3_table" value="" onKeyPress="return is_number(this,event);" onblur="validate_number_range(this, 0, 23)"><% tcWebApi_Get("String_Entry", "Hour", "s") %>
					<input type="text" maxlength="2" name="wl_expire_min" class="input_3_table" value="" onKeyPress="return is_number(this,event);" onblur="validate_number_range(this, 0, 59)"> <% tcWebApi_Get("String_Entry", "Minute", "s") %>
					<input type="radio" value="0" name="wl_expire_radio" class="content_input_fd" onClick=""><% tcWebApi_Get("String_Entry", "Limitless", "s") %>
					</td>
				</tr>

			 	<tr>
					<th><a class="hintstyle" href="javascript:void(0);" onClick="openHint(0, 26);"><%tcWebApi_get("String_Entry","Access_Intranet","s")%></a></th>
					<td>
				 		<select name="wl_lanaccess" class="input_option">
							<option value="on" <% if tcWebApi_get("WLan_Entry","lanaccess","h") = "on" then asp_Write("selected") end if %>><%tcWebApi_get("String_Entry","WC11b_WirelessCtrl_button1name","s")%></option>
							<option value="off" <% if tcWebApi_get("WLan_Entry","lanaccess","h") = "off" then asp_Write("selected") end if %>><%tcWebApi_get("String_Entry","WC11b_WirelessCtrl_buttonname","s")%></option>
			  		</select>
					</td>
			 	</tr>				
				<tr>
					<th><%tcWebApi_get("String_Entry","enable_macmode","s")%></th>
					<td>
							<select name="wl_macmode" class="input_option" onChange="maclistMain_display(this);">
								<option class="content_input_fd" value="disabled" <% if tcWebApi_get("ACL_Entry0","wl_macmode","h") = "disabled" then asp_Write("selected") end if %>><%tcWebApi_get("String_Entry","btn_disable","s")%></option>
								<option class="content_input_fd" value="allow" <% if tcWebApi_get("ACL_Entry0","wl_macmode","h") = "allow" then asp_Write("selected") end if %>><%tcWebApi_get("String_Entry","FC_MFMethod_item1","s")%></option>
								<option class="content_input_fd" value="deny" <% if tcWebApi_get("ACL_Entry0","wl_macmode","h") = "deny" then asp_Write("selected") end if %>><%tcWebApi_get("String_Entry","FC_MFMethod_item2","s")%></option>
							</select>
					</td>
				</tr>
			</table>
			
			<div id="maclistMain">
			<table id="maclistTable" width="80%" border="1" align="center" cellpadding="4" cellspacing="0" class="FormTable_table">
				<thead>
				<tr>
					<td colspan="2"><%tcWebApi_get("String_Entry","FC_MFList_groupitemname","s")%>&nbsp;(<%tcWebApi_get("String_Entry","List_limit","s")%>&nbsp;16)</td>
				</tr>
				</thead>
				<tr>
					<th width="80%"><a class="hintstyle" href="javascript:void(0);" onClick="openHint(5,10);">Client Name (MAC address)<!--untranslated--></th> 
					<th width="20%"><%tcWebApi_get("String_Entry","list_add_delete","s")%></th>
				</tr>
				<tr>
					<td width="80%">
						<input type="text" maxlength="17" class="input_macaddr_table" name="wl_maclist_x_0" onKeyPress="return is_hwaddr(this,event)" onClick="hideClients_Block();" autocorrect="off" autocapitalize="off" placeholder="ex: <% tcWebApi_get("Info_Ether","mac","s") %>" style="width:255px;">
						<img id="pull_arrow" height="14px;" src="/images/arrow-down.gif" style="position:absolute;display:none;" onclick="pullWLMACList(this);" title="<%tcWebApi_get("String_Entry","select_wireless_MAC","s")%>" onmouseover="over_var=1;" onmouseout="over_var=0;">
						<div id="WL_MAC_List_Block" class="WL_MAC_Block"></div>
					</td>
					<td width="20%">	
						<input type="button" class="add_btn" onClick="addRow(document.form.wl_maclist_x_0, 16);" value="">
					</td>
				</tr>      		
			</table>
			
			<div id="wl_maclist_x_Block"></div>
			</div>

			<div class="apply_gen" id="applyButton">
				<input type="button" class="button_gen" value="<%tcWebApi_get("String_Entry","CTL_Cancel","s")%>" onclick="guest_divctrl(0);">
				<input type="button" class="button_gen" value="<%tcWebApi_get("String_Entry","CTL_apply","s")%>" onclick="applyRule();">
			</div>
		  </td>
		</tr>
		</tbody>

	  </table>
	</td>
</form>
</tr>
</table>
<!--===================================Ending of Main Content===========================================-->

	</td>

	<td width="10" align="center" valign="top"></td>
  </tr>
</table>

<div id="footer"></div>
</body>
<!--Guest_network.asp-->
</html>

