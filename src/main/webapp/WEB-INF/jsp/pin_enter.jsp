<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="webjars/jquery/2.2.0/jquery.min.js"></script>
    <link rel='stylesheet' href='webjars/bootstrap/3.1.0/css/bootstrap.min.css'>
    <link rel="stylesheet" href="resources/css/common.css">
    <title>ATM</title>
</head>
<body>
<div class="container" id="thin">
    <jsp:include page="fragments/logout_header.jsp"/>
    <div class="main_frame">

        <h2 class="form-signin-heading">Enter pin code</h2>
        <form id="form" class="form-signin" action="cabinet" method="POST">
            <input type="hidden" name="card" value="${card}" id="card">
            <input type="hidden" name="pin" id="hidden_field">
            <input type=text id="visible_field" class="form-control" required readonly>
        </form>
        <jsp:include page="fragments/keypad.jsp"/>
    </div>
</div>

</body>
<script type="text/javascript">

    var $field = $('#visible_field');
    var $hiddenField = $('#hidden_field');
    var $keys = $('.keys button');
    var count = $hiddenField.val().length;
    maxCount = 4;
    fieldMask = '____';

    $keys.on('click', function () {
        var val = this.textContent;
        switch (val) {
            case "C":
                clearField();
                break;
            case "Ok":
                sendForm();
                break;
            default:
                addNumberIfNecessary(val);
        }
    });

    function clearField() {
        $field.val('');
        $hiddenField.val('');
        count = 0;
    }

    function addNumberIfNecessary(val) {
        switch (count) {
            case maxCount:
                break;
            case 0:
                $field.val(fieldMask);
            default:
                $field.val($field.val().replace("_", "○"));
                $hiddenField.val($hiddenField.val() + val);
                count++;

        }
    }

    function sendForm() {
        if (count == maxCount) {
            $('#form').submit();
        } else {
            alert('Expected ' + maxCount + ' numbers');
        }
    }

</script>
</html>
