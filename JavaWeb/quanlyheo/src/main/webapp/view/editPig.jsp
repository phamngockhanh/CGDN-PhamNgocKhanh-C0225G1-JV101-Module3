<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        .form-container {
            max-width: 500px;
            margin: 30px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
            background-color: #f9f9f9;
            font-family: Arial, sans-serif;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 8px 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #66afe9;
            outline: none;
        }

        .form-container button {
            width: 100%;
            padding: 10px;
            background-color: #dfa425;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }

        .form-container button:hover {
            background-color: #e8b74e;
        }
    </style>
</head>

<body>
<form method="post" class="form-container" id="input-form">
    <h2>Thông tin con heo</h2>
    <div class="form-group">
        <label>Mã số heo:</label>
        <input name="id" id="id" value="${pig.id}" >
        <div id="error-pigId" class="text-danger small mt-1"></div>
    </div>

    <div class="form-group">
        <label>Thời gian nhập:</label>
        <input type="date" name="timeIn" id="timeIn"  value="${pig.timeIn}" required>
        <div id="error-timeIn" class="text-danger small mt-1"></div>
    </div>
    <div class="form-group">
        <label>Thời gian xuất:</label>
        <input type="date" name="timeOut" id="timeOut"  value="${pig.timeOut}">
        <div id="error-timeOut" class="text-danger small mt-1"></div>
    </div>

    <div class="form-group">
        <label>Khối lượng khi nhập chuồng:</label>
        <input name="weightIn" id="weightIn"  value="${pig.weightIn}" required>
        <div id="error-weightIn" class="text-danger small mt-1"></div>
    </div>

    <div class="form-group">
        <label>Khối lượng khi xuất chuồng:</label>
        <input name="weigthOut" id="weigthOut"  value="${pig.weightOut}" required>
        <div id="error-weigthOut" class="text-danger small mt-1"></div>
    </div>

    <div class="form-group">
        <label>Loại khóa học:</label>
        <select name="manufactureId" id="manufactureId" required>
            <option value="0">Chọn nhà cung cấp</option>
            <c:forEach var="manufacture" items="${manufactures}">
                <option value="${manufacture.id}"
                        <c:if test="${manufacture.id == pig.manufactureId}">selected</c:if>>${manufacture.name}</option>
            </c:forEach>
        </select>
        <div id="error-manufactureId" class="text-danger small mt-1"></div>
    </div>

    <button type="submit">Cập nhật</button>
</form>
<script>
    document.querySelector("#input-form").addEventListener("submit", function (e) {
        let isValid = true;

        document.querySelectorAll(".text-danger").forEach(el => el.textContent = "");

        const pattern = /^MH-\d{3}$/;
        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/;
// Ví dụ hợp lệ: test@gmail.com, user.name@domain.co
        const phonePattern = /^0\d{9}$/;
// Ví dụ hợp lệ: 0912345678
        const passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$/;
// Ví dụ hợp lệ: abc12345, A1b2c3d4
        const numberPattern = /^\d+$/;
// Ví dụ hợp lệ: 123, 000456
        const letterPattern = /^[a-zA-Z]+$/;
// Ví dụ hợp lệ: abcXYZ
        const datePattern = /^\d{4}-\d{2}-\d{2}$/;
// Ví dụ hợp lệ: 2025-06-13
        const idCardPattern = /^\d{9}(\d{3})?$/;
// Ví dụ hợp lệ: 123456789, 123456789123
        let pidId = document.getElementById("pidId").value.trim();
        if(!pattern.test(pidId)){
            document.getElementById("error-pidId").textContent = "Nhập đúng định dạng MH-xxx với x là số từ 1 - 10!";
            isValid = false;
        }



        let timeIn = document.getElementById("timeIn");
        if(timeIn.value.trim() === ""){
            document.getElementById("error-timeIn").textContent = "Ngày xuất không được để trống";
            isValid = false;
        }

        let weightIn = document.getElementById("weightIn");
        if(weightIn.value < 10){
            document.getElementById("error-weightIn").textContent = "Hãy nhập cân nặng khi nhập";
            isValid = false;
        }

        let weigthOut = document.getElementById("weigthOut");
        if(weigthOut.value< 10){
            document.getElementById("error-weightIn").textContent = "Hãy nhập cân nặng khi xuất";
            isValid = false;
        }


        let manufactureId = document.getElementById("manufactureId");
        if(manufactureId.value=== "0"){
            document.getElementById("error-manufactureId").textContent = "Vui lòng chọn nhà cung cấp"
            isValid = false;
        }

        if (!isValid) {
            e.preventDefault();
        }
    });
</script>
</body>
</html>
