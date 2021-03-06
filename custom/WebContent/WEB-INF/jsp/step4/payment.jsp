<%@ page import="com.payabbhi.model.Order"%>
<%@ page import="java.lang.Integer"%>

<h1 class="cover-heading">Limited Offer Sale !!</h1>
<p class="lead">Purchase a random superhero to run your errands. Try your luck.</p>

<%
	Order neworder = (Order)request.getAttribute("order");
%>

<p class="lead">
<button id="submit-btn" class="btn btn-lg btn-default">Pay with Payabbhi</button>
<script src="https://checkout.payabbhi.com/v1/checkout.js"></script>
<form name='payabbhiform' action="${pageContext.request.contextPath}/step4/status" method="POST">
<input type="hidden" name="merchant_order_id" value="${param.merchantorderid}"></input>
    <input type="hidden" name="order_id" id="order_id">
    <input type="hidden" name="payment_id" id="payment_id">
    <input type="hidden" name="payment_signature"  id="payment_signature" >
</form>
<script>
// Implement the Checkout workflow for Web as outlined at https://payabbhi.com/docs/checkout
var options = {
    "access_id": "<%=(String)request.getAttribute("access_id")%>",
	"order_id":  "<%=(String)neworder.get("id")%>",
	"amount": "<%=(Integer)neworder.get("amount")%>",
	"name": "SuperHeroes Store",
	"description": "Order # ${param.merchantorderid}",
	"image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRrqxgvtb3CZ9MJOKpXWxrScQEK4lwzbClXg_J7iayii4PTg-Y5",
	"prefill": {
	    "name":    "Bruce Wayne",
	    "email":   "bruce@wayneinc.com",
	    "contact": "9999999999"
	},
	"notes": {
	    "merchant_order_id": "${param.merchantorderid}"
	    },
	    "theme": {
	        "color": "#F6A821"
	    }
	};
	options.handler = function (response){
	    document.getElementById('order_id').value = response.order_id;
	    document.getElementById('payment_id').value = response.payment_id;
	    document.getElementById('payment_signature').value = response.payment_signature;
	    document.payabbhiform.submit();
	};
	
	document.getElementById('submit-btn').onclick = function(e){
	    var payabbhi = new Payabbhi(options);
	    payabbhi.open();
	    e.preventDefault();
	}
</script>
</p>