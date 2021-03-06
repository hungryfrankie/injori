<!-- IF PAGE eq 0 -->
<style>
input[type="radio"]:disabled {
    -webkit-appearance: none;
    display: inline-block;
    width: 12px;
    height: 12px;
    padding: 0px;
    background-clip: content-box;
    border: 4px solid DodgerBlue;
    background-color: white;
    border-radius: 50%;
}
</style>
<script type="text/javascript">
$('[data-toggle="popover"]').popover();

$('body').on('click', function (e) {
    $('[data-toggle="popover"]').each(function () {
        //the 'is' for buttons that trigger popups
        //the 'has' for icons within a button that triggers a popup
        if (!$(this).is(e.target) && $(this).has(e.target).length === 0 && $('.popover').has(e.target).length === 0) {
            $(this).popover('hide');
        }
    });
});
$(document).ready(function(){
$('[data-toggle="popover"]').popover(); 

});

$(document).ready(function(){
	// set up the page
	// do something
	//sell javascript
	$("#bn_only_no").click(function() {
		$(".additional_shipping_costhide").hide();
		$("#additional_shipping_cost").attr("disabled","disabled");
			$("#min_bid").removeAttr("disabled");
			$("#reserve_price").removeAttr("disabled");
			$("#iqty").attr("disabled","disabled");
			$("#iqty").val("1");
	});
	$("#bn_only_yes").click(function() {
		$(".additional_shipping_costhide").show();
		$("#additional_shipping_cost").removeAttr("disabled","disabled");
			$("#min_bid").attr("disabled","disabled");
			$("#reserve_price").attr("disabled","disabled");
			$("#with_reserve_no").attr("checked", "checked");
			$("#iqty").removeAttr("disabled");
			$("#bn_yes").attr("checked", "checked");
			$("#bn").removeAttr("disabled");
	});
	$("#reserve_price").focus(function() {
		$("#with_reserve_yes").attr("checked", "checked");
	});
	
	$("#bn").focus(function() {
		$("#bn_yes").attr("checked", "checked");
	});
	$("#bn_no").click(function() {
		$("#bn_only_no").attr("checked", "checked");
		$("#min_bid").removeAttr("disabled");
		$("#reserve_price").removeAttr("disabled");
		$("#iqty").attr("disabled","disabled");
		$("#iqty").val("1");
	});
	$("#custominc").focus(function() {
		$("#inc2").attr("checked", "checked");
	});
	$("#atype").change(function() {
		if (($(this).find(':selected').val() == 2)||($(this).find(':selected').val() == 3))
		{
			//dutch auction
			$("#additional_shipping_cost").attr("disabled","disabled");
			$("#additional_shipping_cost").removeAttr("disabled","disabled");
			$("#with_reserve_no").attr("checked", "checked");
			$("#bn_only_no").attr("checked", "checked");
			$("#bn_no").attr("checked", "checked");
			$("#inc1").attr("checked", "checked");
			$("#iqty").removeAttr("disabled");
			$("#min_bid").removeAttr("disabled");
			$(".dutchhide").hide();
			$("#minval_text").text("{L_038}");
			$(".dutchshow").show();
		}
		else
		{
			//normal auction
			$("#additional_shipping_cost").removeAttr("disabled","disabled");
			$(".additional_shipping_costhide").hide();
			$(".dutchhide").show();
			$("#iqty").attr("disabled","disabled");
			$("#iqty").val("1");
			$("#minval_text").text("{L_020}");
			$(".dutchshow").hide();
		}
	});
	$("#bps").click(function() {
		$("#shipping_cost").removeAttr("disabled");
	});
	$(".sps").click(function() {
		$("#additional_shipping_cost").removeAttr("disabled","disabled");
		$(".additional_shipping_costhide").hide();
		$("#shipping_cost").attr("disabled","disabled");
		$("#shipping_cost").val("0.00");
	});
	<!-- IF B_FEES -->
	{FEE_JS}
	// something
	var min_bid_fee = {FEE_MIN_BID};
	var bn = {FEE_BN};
	var rp = {FEE_RP};
	var st = {FEE_SUBTITLE};
	st = st * 1;
	var rl = {FEE_RELIST};
	$("#min_bid").blur(function() {
		var min_bid = parseFloat($("#min_bid").val());
		updatefee(min_bid_fee * -1);
		min_bid_fee = 0; // just incase theres nothing
		if (min_bid == 0)
		{
			min_bid_fee = 0;
		}
		else
		{
			for (var i = 0; i < setup_fee.length; i++)
			{
				if (setup_fee[i][0] <= min_bid && setup_fee[i][1] >= min_bid)
				{
					if (setup_fee[i][3] == 'flat')
					{
						min_bid_fee = setup_fee[i][2];
						updatefee(setup_fee[i][2]);
					}
					else
					{
						min_bid_fee = (setup_fee[i][2] / 100) * min_bid;
						updatefee(min_bid_fee);
					}
					break;
				}
			}
		}
	});
	$("#resetbt").click(function() {
		current_fee = current_fee.toFixed({FEE_DECIMALS});
		$("#fee_exact").val(current_fee);
		$("#to_pay").text(current_fee);
	});
	$("#bn").blur(function() {
		bin();
	});
	$("#bn_yes").click(function() {
		bin();
	});
	$("#bn_no").click(function() {
		$("#bn").val(0);
		bin();
	});
	function bin() {
		if (bn != parseInt($("#bn").val()))
		{
			if (parseInt($("#bn").val()) > 0)
				updatefee(buynow_fee);
			else
				updatefee(buynow_fee * -1);
			bn = parseInt($("#bn").val());
		}
	}
	$("#reserve_price").blur(function() {
		reserve();
	});
	$("#with_reserve_yes").click(function() {
		reserve();
	});
	$("#with_reserve_no").click(function() {
		$("#reserve_price").val(0);
		reserve();
	});
	
	function reserve() {
		if (rp != parseInt($("#reserve_price").val()))
		{
			if (parseInt($("#reserve_price").val()) > 0)
				updatefee(reserve_fee);
			else
				updatefee(reserve_fee * -1);
			rp = parseInt($("#reserve_price").val());
		}
	}
	$("#is_featured").click(function() {
		if ($('#is_featured').is(':checked'))
			updatefee(featured_fee);
		else
			updatefee(featured_fee * -1);
	});


     
	
	
	
    $("#with_offer_yes").click(function() {
		make_offer();
	});
	
	
    $("#with_offer_no").click(function() {
	    $("#make_offer_reject").val(0);
        $("#make_offer_accept").val(0);
		make_offer();
	});
	
    function make_offer() {
		
		if ($('#with_offer_yes').is(':checked')){
			updatefee(offer_fee);
			 document.getElementById("with_offers").value="yes";
            document.getElementById("with_offer_yes").disabled = true;  
		    document.getElementById("with_offer_no").disabled = false; 
	    }
        if ($('#with_offer_no').is(':checked')){
			updatefee(offer_fee * -1);	
			document.getElementById("with_offers").value="no";
			document.getElementById("with_offer_no").disabled = true;  
		    document.getElementById("with_offer_yes").disabled = false; 
	    }
	}
	$("#is_bold").click(function() {
		if ($('#is_bold').is(':checked'))
			updatefee(bold_fee);
		else
			updatefee(bold_fee * -1);
	});
	$("#is_highlighted").click(function() {
		if ($('#is_highlighted').is(':checked'))
			updatefee(highlighted_fee);
		else
			updatefee(highlighted_fee * -1);
	});
		<!-- IF B_SUBTITLE -->
	$("#subtitle").blur(function() {
		if (st > 0 && $("#subtitle").val().length == 0)
		{
			updatefee(subtitle_fee * -1);
			st = 0;
		}
		if (st == 0 && $("#subtitle").val().length > 0)
		{
			updatefee(subtitle_fee);
			st = subtitle_fee;
		}
	});
		<!-- ENDIF -->
		<!-- IF B_AUTORELIST -->
	$("#autorelist").blur(function() {
		var rl_times = $("#autorelist").val();
		updatefee(relist_fee * rl * -1);
		updatefee(relist_fee * rl_times);
		rl = rl_times;
	});
		<!-- ENDIF -->
	function updatefee(newfee) {
		var nowfee = parseFloat($("#fee_exact").val()) + newfee;
		$("#fee_exact").val(nowfee);
		nowfee = nowfee - current_fee;
		if (nowfee < 0)
		{
			nowfee = 0;
		}
		nowfee = nowfee.toFixed({FEE_DECIMALS});
		$("#to_pay").text(nowfee);
	}
	<!-- ENDIF -->
});
</script>
<!-- ENDIF -->
<!-- IF ATYPE_PLAIN eq 2 -->
<style type="text/css">
.dutchhide {
	display: none;
}
</style>
<!-- ENDIF -->
<div class="row">
	<div class="col-md-12">
		<div class="col-md-8 col-md-offset-2 well">
			<legend>{TITLE}</legend>
			<div class="table2">
				<a name="goto"></a>
<!-- IF ERROR ne '' -->
				<div class="alert alert-danger" role="alert">
					{ERROR}
				</div>
<!-- ENDIF -->
<!-- IF PAGE eq 0 -->
				<form name="sell" action="{SITEURL}sell.php" method="post">
					<input type="hidden" name="csrftoken" value="{_CSRFTOKEN}">
					<div class="form-group col-md-12">
						<label>{L_287}</label>
						{CAT_LIST1}
	<!-- IF CAT_LIST2 ne '' -->
						{CAT_LIST2}
	<!-- ENDIF -->
						<a class="btn btn-primary btn-xs" href="select_category.php?change=yes">{L_5113}</a>
						<LABEL><a data-toggle="popover" title="{L_19733}" data-content="{L_9733}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></LABEL>
						
					</div>
					<div class="form-group col-md-12">
						<label for="title">{L_017}   <a data-toggle="popover" title="{L_19701}" data-content="{L_9701}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<div class="row">
							<input type="text" name="title" class="form-control" value="{AUC_TITLE}"> 
							
						</div>
					</div>
	<!-- IF B_SUBTITLE -->
					<div class="form-group col-md-12">
						<label for="title">{L_806}   <a data-toggle="popover" title="{L_19702}" data-content="{L_9702}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
	<div class="row">
							
								<input type="text" name="subtitle"  class="form-control" value="{AUC_SUBTITLE}"> 
							</div>
						
					</div>
	<!-- ENDIF -->

				
					<div class="form-group col-md-12">
						<label for="subtitle">{L_018}  <a data-toggle="popover" title="{L_19708}" data-content="{L_9708}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						{AUC_DESCRIPTION}
					</div>
	<!-- IF B_GALLERY -->
					<legend>{L_663}</legend>
					<div class="form-group col-md-12">
						<div class="alert alert-info" role="alert">{MAXPICS}</div>
						<a href="upldgallery.php" alt="gallery" class="btn btn-primary new-window">{L_677}</a>
						<input type="hidden" name="numimages" value="{NUMIMAGES}" id="numimages">
						<hr />
					</div>
	<!-- ENDIF -->
					<div class="form-group col-md-12">
						<div class="alert alert-warning" role="alert">{L_640}</div>
					</div>
					<div class="form-group col-md-12">
						<label for="auctiontype">{L_257}   <a data-toggle="popover" title="{L_19709}" data-content="{L_9709}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
							<div class="row">
							<div class="auctiontype ">{ATYPE}</div>
						</div>
					</div>
					<div class="form-group col-md-12">
						<label for="iquantity">{L_258}  <a data-toggle="popover" title="{L_19710}" data-content="{L_9710}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<div class="row">
							
								<input type="text" name="iquantity" id="iqty" class="form-control" value="{ITEMQTY}" {ITEMQTYD}>
							
						</div>
					</div>
					<div class="form-group col-md-12">
						<label for="minimum_bid" id="minval_text">{MINTEXT}  <a data-toggle="popover" title="{L_19711}" data-content="{L_9711}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<div class="row">
							
								<input type="text" class="form-control" name="minimum_bid" id="min_bid" value="{MIN_BID}" {BN_ONLY}>
							
							{CURRENCY}
						</div>
					</div>
	<!-- IF B_CUSINC -->
					<div class="form-group col-md-12 dutchhide">
						<label>{L_120}  <a data-toggle="popover" title="{L_019}" data-content="{L_9011}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<div class="radio">
							<label class="radio-inline">
								<input type="radio" name="increments" id="inc1" value="1" {INCREMENTS1}>
								{L_614}
							</label>
							<label class="radio-inline">
								<input type="radio" name="increments" id="inc2" value="2" {INCREMENTS2}>
								{L_615}</label>
						</div>
						<input type="text" name="customincrement" id="custominc" class="form-control" value="{CUSTOM_INC}">
						{CURRENCY}
					</div>
	<!-- ELSE -->
					<input type="hidden" name="increments" id="inc1" value="1">
	<!-- ENDIF -->
					<div class="form-group col-md-12 dutchhide">
						<label>{L_021}  <a data-toggle="popover" title="{L_19712}" data-content="{L_9712}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<div class="radio">
							<label class="radio-inline">
								<input type="radio" name="with_reserve" id="with_reserve_no" value="no" {RESERVE_N}>
								{L_no}</label>
							<label class="radio-inline">
								<input type="radio" name="with_reserve" id="with_reserve_yes" value="yes" {RESERVE_Y}>
								{L_yes}</label>
						</div>
						<input type="text" name="reserve_price" id="reserve_price" class="form-control" value="{RESERVE}" {BN_ONLY}>
						{CURRENCY}
					</div>
	<!-- IF B_BN_ONLY -->
					<div class="form-group col-md-12 dutchhide">
						<label>{L_30_0063}  <a data-toggle="popover" title="{L_19714}" data-content="{L_9714}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<div class="radio">
							<label class="radio-inline">
								<input type="radio" name="buy_now_only" value="0" {BN_ONLY_N} id="bn_only_no">
								{L_no}</label>
							<label class="radio-inline">
								<input type="radio" name="buy_now_only" value="1" {BN_ONLY_Y} id="bn_only_yes">
								{L_yes}</label>
						</div>
					</div>
	<!-- ENDIF -->

					<div class="form-group col-md-12 dutchhide" >

						<label>{L_496}  <a data-toggle="popover" title="{L_019}" data-content="{L_9011}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<div class="radio">
							<label class="radio-inline">
								<input type="radio" name="buy_now" id="bn_no" value="no" {BN_N}>
								{L_no}</label>
							<label class="radio-inline">
								<input type="radio" name="buy_now" id="bn_yes" value="yes" {BN_Y}>
								{L_yes}</label>
						</div>
							<label>{L_496}  <a data-toggle="popover" title="{L_19715}" data-content="{L_9715}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<input type="text" name="buy_now_price" id="bn" class="form-control" value="{BN_PRICE}">
						{CURRENCY}
					</div>
	
	<!-- IF B_SHOW_OFFERME -->
	<!-- IF B_SHOW_OFFERME_ZERO -->
	<div class="form-group col-md-12 " >
    	
		<!-- ENDIF -->
	<!-- IF B_SHOW_OFFERME_ONE-->
	<div class="form-group col-md-12  dutchshow "  style="display:none;">
	<!-- ENDIF -->
	<!-- IF B_SHOW_OFFERME_TWO -->
	<div class="form-group col-md-12 dutchhide" >
	<!-- ENDIF -->	
			

						<label>{L_9021}  <a data-toggle="popover" title="{L_19716}" data-content="{L_9716}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<div class="radio">
								<label class="radio-inline">
								<input type="radio" name="make_offer" id="with_offer_no" value="no" {OFFER_N}>
								{L_no}</label>
							<label class="radio-inline">
								<input type="radio" name="make_offer" id="with_offer_yes" value="yes" {OFFER_Y}>
								{L_yes}</label>
								<br>
						<label>{L_9022}  <a data-toggle="popover" title="{L_19717}" data-content="{L_9717}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<div><input type="text" name="make_offer_reject" id="make_offer_reject" class="form-control" value="{MAKE_OFFER_REJECT}">
	                    {CURRENCY}</div>
                        <label>{L_9023}  <a data-toggle="popover" title="{L_19718}" data-content="{L_9718}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<div><input type="text" name="make_offer_accept" id="make_offer_accept" class="form-control" value="{MAKE_OFFER_ACCEPT}">
	                {CURRENCY}</div>
					<input type="hidden" name="with_offers" id="with_offers">
					</div>
			<!-- ENDIF -->		
	<!-- IF B_EDIT_STARTTIME -->
					<div class="form-group col-md-12">
						<label for="a_starts">{L_2__0016} </label>
		<!-- IF B_EDITING && B_CANEDITSTARTDATE eq false -->
						{START_TIME}
						<input type="hidden" name="a_starts" value="{START_TIME}">
		<!-- ELSE -->
						<div class="checkbox">
							<label>
								<input type="checkbox" name="start_now" id="start_now" {START_NOW}> {L_211}
	</label>
						</div>
						<label>{L_260}  <a data-toggle="popover" title="{L_19724}" data-content="{L_9724}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<input type="text" name="a_starts" id="pubdate_input" value="{START_TIME}" class="form-control">
						<script type="text/javascript">
							new tcal ({'id': 'pubdate_input', 'controlname': 'a_starts', 'formname': 'sell', 'now': 'start_now'});
							$('#pubdate_input').change(function () {
								$('#start_now').attr('checked', false);
							});
						</script>
		<!-- ENDIF -->
					</div>
	<!-- ELSE -->
					<input type="hidden" name="start_now" value="1">
	<!-- ENDIF -->
	<!-- IF B_EDIT_ENDTIME -->
					<div class="form-group col-md-12">
						<label>{L_custom_end_time}    <a data-toggle="popover" title="{L_19726}" data-content="{L_9726}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<div class="row">
							<div class="duration "><input type="checkbox" name="custom_end" {CUSTOM_END}></div>
						</div>
					</div>
	<!-- ENDIF -->
					<div class="form-group col-md-12">
						<label>{L_ending_date}</label>
						<div class="row">
							<div class="duration ">
	        					{L_022}: {DURATIONS}<br>
				<!-- IF B_EDIT_ENDTIME -->
								{L_or_custom_end_time}: <input type="text" name="a_ends" id="a_ends" value="{END_TIME}" size="20" maxlength="19" class="form-control">
								<script type="text/javascript">
									new tcal ({'id': 'a_ends','controlname': 'a_ends', 'formname': 'sell'});
									$('#a_ends').change(function () {
										$('#custom_end').attr('checked', true);
									});
								</script>
				<!-- ENDIF -->
							</div>
						</div>
					</div>
	<!-- IF B_AUTORELIST -->
					<div class="form-group col-md-12">
						<label>{L__0161}</label>
						<p class="bg-info sm-padding">{L__0162}</p>
						<div class="row">
							<div class="relist ">{RELIST}</div>
						</div>
					</div>
	<!-- ENDIF -->
	<!-- IF B_SHIPPING -->
					<legend>{L_864}</legend>
                    	
					
					
					<div class="form-group col-md-12">
						<label for="item_lenght">{L_023}  <a data-toggle="popover" title="{L_19720}" data-content="{L_9720}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
				<div class="row">
							
								<input type="text" class="form-control" name="shipping_cost" id="shipping_cost" value="{SHIPPING_COST}" <!-- IF SHIPPING1 eq '' -->disabled="disabled"<!-- ENDIF --> >
								{CURRENCY}
							
						</div>
					</div>
					<div class="form-group col-md-12 additional_shipping_costhide">
						<label for="item_lenght">{L_350_1008}  <a data-toggle="popover" title="{L_19721}" data-content="{L_9721}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
				<div class="row">
							
								<input type="text" class="form-control" name="additional_shipping_cost" id="additional_shipping_cost" value="{ADDITIONAL_SHIPPING_COST}" <!-- IF SHIPPING1 eq '' -->disabled="disabled"<!-- ENDIF -->>
								{CURRENCY}
							
						</div>
					</div>
					<div class="form-group col-md-12">
						<label>{L_025}</label>
						<div class="radio">
							<label>
								<input type="radio" name="shipping" id="bps" value="1" {SHIPPING1}>
								{L_031}
			</label>
							<br>
							<label>
								<input type="radio" name="shipping" id="sps" value="2" {SHIPPING2}>
								{L_032}</label>
							<br>
							<label>
								<input type="radio" name="shipping" id="sps" value="3" {SHIPPING3}>
								{L_867}</label>
							<br>
						</div>
						<div class="checkbox">
							<label>
								<input type="checkbox" name="international" value="1" {INTERNATIONAL}>
								{L_033}/label>
						</div>
					</div>
					<div class="form-group col-md-12">
						<label for="shipping_terms">{L_25_0215}  <a data-toggle="popover" title="{L_19727}" data-content="{L_9727}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<textarea name="shipping_terms" rows="3" class="form-control">{SHIPPING_TERMS}</textarea>
					</div>
	<!-- ENDIF -->
					<legend>{L_30_0080}</legend>
					<div class="form-group col-md-12">
						<label>{L_026}  <a data-toggle="popover" title="{L_19732}" data-content="{L_9732}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<div class="checkbox">
							{PAYMENTS}
						</div>
					</div>
					<legend>{L_268}</legend>
	<!-- IF B_MKFEATURED or B_MKBOLD or B_MKHIGHLIGHT -->
					<div class="form-group col-md-12">
						<div class="checkbox">
		<!-- IF B_MKFEATURED -->
							<P><input type="checkbox" name="is_featured" id="is_featured" {IS_FEATURED}> {L_273}<label><a data-toggle="popover" title="{L_19729}" data-content="{L_9729}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9723}" width="15" height="15"></a></label><br></P>
		<!-- ENDIF -->
		<!-- IF B_MKBOLD -->
							<P><input type="checkbox" name="is_bold" id="is_bold" {IS_BOLD}> {L_274}<label><a data-toggle="popover" title="{L_19730}" data-content="{L_9730}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9730}" width="15" height="15"></a></label><br></P>
		<!-- ENDIF -->
		<!-- IF B_MKHIGHLIGHT -->
							<P><input type="checkbox" name="is_highlighted" id="is_highlighted" {IS_HIGHLIGHTED}> {L_292}<label><a data-toggle="popover" title="{L_19731}" data-content="{L_9731}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9731}" width="15" height="15"></a></label></P>
		<!-- ENDIF -->
						</div>
					</div>
	<!-- ENDIF -->
	<!-- IF B_CAN_TAX -->
					<div class="form-group col-md-12">
						<label>{L_1102}  <a data-toggle="popover" title="{L_019}" data-content="{L_9011}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<div class="radio">
							<label class="radio-inline">
								<input type="radio" name="is_taxed" value="1" {TAX_Y}>	{L_yes}
							<a data-toggle="popover" title="{L_019}" data-content="{L_9011}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
							<label class="radio-inline">
								<input type="radio" name="is_taxed" value="0" {TAX_N}> {L_no}
							<a data-toggle="popover" title="{L_019}" data-content="{L_9011}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						</div>
					</div>
					<div class="form-group col-md-12">
						<label>{L_1103}  <a data-toggle="popover" title="{L_019}" data-content="{L_9011}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						<div class="radio">
							<label class="radio-inline">
								<input type="radio" name="tax_included" value="1" {TAXINC_Y}>	{L_yes}
							<a data-toggle="popover" title="{L_019}" data-content="{L_9011}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
							<label class="radio-inline">
								<input type="radio" name="tax_included" value="0" {TAXINC_N}> {L_no}
							<a data-toggle="popover" title="{L_019}" data-content="{L_9011}"><img src="{SITEURL}themes/modern2/img/info_button_s.png" alt="{L_9011}" width="15" height="15"></a></label>
						</div>
					</div>
	<!-- ENDIF -->
	<!-- IF B_FEES -->
					<div class="form-group col-md-12">
						<input type="hidden" name="fee_exact" id="fee_exact" value="{FEE_VALUE}">
						<div class="alert alert-info" role="alert">
							<b>{L_1151}: </b><span class="text-danger" id="to_pay"> {FEE_VALUE_F} </span><small> {CURRENCY}</small>
						</div>
					</div>
	<!-- ENDIF -->
					<div style="text-align:center">
						<input type="hidden" value="3" name="action">
						<input type="submit" name="" value="{L_5189}" class="btn btn-primary">&nbsp;&nbsp;&nbsp;
						<input type="reset" id="resetbt" value="{L_5190}" class="btn btn-warning">
					</div>
				</form>
<!-- ELSEIF PAGE eq 2 -->
				<form name="preview" action="{SITEURL}sell.php" method="post">
					<input type="hidden" name="csrftoken" value="{_CSRFTOKEN}">
					<table class="table table-striped table-bordered">
						<tr>
							<td colspan="2" align="center">{L_046}</td>
						</tr>
						<tr>
							<td width="40%" align="right"  valign="top"><b>{L_017}</b></td>
							<td width="60%" >{TITLE}</td>
						</tr>
	<!-- IF B_SUBTITLE -->
						<tr>
							<td width="40%" align="right"  valign="top"><b>{L_806}</b></td>
							<td width="60%" >{SUBTITLE}</td>
						</tr>
	<!-- ENDIF --> 
						<tr>
							<td  valign="top" align="right"><b>{L_018}</b></td>
							<td>{AUC_DESCRIPTION}</td>
						</tr>
						<tr>
							<td  valign="top" align="right"><b>{L_019}</b></td>
							<td>{PIC_URL}</td>
						</tr>
	<!-- IF B_GALLERY -->
						<tr>
							<td width="260" valign="middle" align="right">&nbsp;</td>
							<td>
								{L_663}<br>
		<!-- BEGIN gallery -->
								<a href="{SITEURL}preview_gallery.php?img={gallery.K}" alt="preview" class="new-window"><img src="{gallery.IMAGE}" width=60 hspace=5 border=0></a>
		<!-- END gallery -->
							</td>
						</tr>
	<!-- ENDIF -->
	<!-- IF B_BN_ONLY -->
						<tr>
							<td valign="top" align="right"><b>{MINTEXT}</b></td>
							<td>{MIN_BID}</td>
						</tr>
	<!-- ENDIF -->
	<!-- IF ATYPE_PLAIN eq 1 -->
		<!-- IF B_BN_ONLY -->
						<tr>
							<td valign="top" align="right"><b>{L_021}</b></td>
							<td>{RESERVE}</td>
						</tr>
		<!-- ENDIF -->
		<!-- IF B_BN -->
						<tr>
							<td valign="top" align="right"><b>{L_496}</b></td>
							<td>{BN_PRICE}</td>
						</tr>
		<!-- ENDIF -->
	<!-- ENDIF -->
	<!-- IF B_SHOW_OFFERME -->
    <tr>
							<td valign="top" align="right"><b>{L_9021}</b></td>
							<td>{WITH_OFFER}</td>
						</tr>
    <tr>
							<td valign="top" align="right"><b>{L_9022}</b></td>
							<td>{MAKE_OFFER_REJECT}</td>
						</tr>
                        <tr>
							<td valign="top" align="right"><b>{L_9023}</b></td>
							<td>{MAKE_OFFER_ACCEPT}</td>
						</tr>
	<!-- IF B_SHIPPING -->
	<!-- ENDIF -->
    
						<tr>
							<td valign="top" align="right"><b>{L_023}</b></td>
							<td>{SHIPPING_COST}</td>
						</tr>
						<tr>
							<td valign="top" align="right"><b>{L_350_1008}</b></td>
							<td>{ADDITIONAL_SHIPPING_COST}</td>
						</tr>
	<!-- ENDIF -->
						<tr>
							<td valign="top" align="right"><b>{L_2__0016}</b></td>
							<td>{STARTDATE}</td>
						</tr>
		<!-- IF CUSTOM_END -->
						<tr>
							<td valign="top" align="right"><b>{L_end_date}</b></td>
							<td>{END_TIME}</td>
						</tr>
		<!-- ELSE -->
						<tr>
							<td valign="top" align="right"><b>{L_022}</b></td>
							<td>{DURATION}</td>
						</tr>
		<!-- ENDIF -->
	<!-- IF B_CUSINC -->
						<tr>
							<td valign="top" align="right"><b>{L_120}</b> </td>
							<td>{INCREMENTS}</td>
						</tr>
	<!-- ENDIF -->
						<tr>
							<td valign="top" align="right"><b>{L_261}</b> </td>
							<td>{ATYPE}</td>
						</tr>
	<!-- IF B_SHIPPING -->
						<tr>
							<td valign="top" align="right"><b>{L_025}</b></td>
							<td>{SHIPPING}<br>{INTERNATIONAL}</td>
						</tr>
						<tr>
							<td align="right" valign="top"><b>{L_25_0215}</b></td>
							<td>{SHIPPING_TERMS}</td>
						</tr>
	<!-- ENDIF -->
						<tr>
							<td valign="top" align="right"><b>{L_026}</b> </td>
							<td>{PAYMENTS_METHODS}</td>
						</tr>
						<tr>
							<td  valign="top" align="right"><b>{L_027}</b></td>
							<td>
								{CAT_LIST1}
	<!-- IF CAT_LIST2 ne '' -->
								<br>{CAT_LIST2}
	<!-- ENDIF -->
							</td>
						</tr>
	<!-- IF B_FEES -->
						<tr>
							<td valign="top" align="right"><b>{L_1151}</b> </td>
							<td>{FEE}</td>
						</tr>
	<!-- ENDIF -->
						<tr>
							<td  valign="top" align="right"></td>
							<td>{L_264}  <a href="{SITEURL}sell.php?mode=recall">{L_265}</a>{L_266}<br></td>
						</tr>
	<!-- IF B_USERAUTH -->
						<tr>
							<td align="right">{L_username}</td>
							<td><b>{YOURUSERNAME}</b><input type="hidden" name="nick" value="{YOURUSERNAME}">
						</tr>
						<tr>
							<td align="right">{L_password}</td>
							<td><input type="password" name="password" class="form-control" value=""></td>
						</tr>
	<!-- ENDIF -->
					</table>
					<div style="text-align:center; padding-top: 10px;">
						<input type="hidden" value="4" name="action">
						<input type="submit" name="" value="{L_2__0037}" class="btn btn-primary">
					</div>
				</form>
<!-- ELSE -->
				<div class="padding">
					{L_100}
					<p>{MESSAGE}</p>
					<ul>
						<li><a href="{SITEURL}item.php?id={AUCTION_ID}&mode=1">{L_101}</a></li>
						<li><a href="{SITEURL}edit_active_auction.php?id={AUCTION_ID}">{L_30_0069}</a></li>
						<li><a href="{SITEURL}sellsimilar.php?id={AUCTION_ID}">{L_2__0050}</a></li>
					</ul>
				</div>
<!-- ENDIF -->
			</div>
		</div>
	</div>
</div></div>
