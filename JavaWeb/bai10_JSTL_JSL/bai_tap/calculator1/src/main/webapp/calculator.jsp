<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form method="post" action="calculator">
    <label>First operand:</label>
    <input type="number" name="first_operand">
    <label>Operator:</label>
    <select name="operation" id="addSelect">
        <option value="+">+</option>
        <option value="-">-</option>
        <option value="*">*</option>
        <option value="/">/</option>
    </select>
    <label>Second operand:</label>
    <input type="number" name="second_operand">
    <button type="submit">Calculate</button>
</form>
</body>
</html>
