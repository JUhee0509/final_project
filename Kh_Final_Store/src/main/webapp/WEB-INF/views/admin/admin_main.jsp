<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String includePage = Common.index.VIEW_PATH + "admin_index.jsp"; %>
<% String check_login = Common.index.VIEW_PATH + "login_admin.jsp"; %>
<%@page import="common.Common"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="/store/resources/js/gango.js"></script>
		<link href="resources/css/consumer_mainpage.css" rel="stylesheet"/>
		<link href="resources/css/product_item.css" rel="stylesheet"/>
		<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
		<script src="/store/resources/js/httpRequest.js"></script>
		
		<style>
			.chart{
				width: 500px;
				height: 800px;
			}
		</style>
	</head>
<body>
    <div class="fixed-header">
        <jsp:include page="<%= includePage %>"/>
    </div><!-- 메인메뉴 받음 -->
    <!-- 광고 이동 페이지 -->
    <div class="wrap">
        <div class="img_header">
            <div class="img_inner"><!-- 메인페이지 사진광고 -->
                <div class="img s1"><img alt="img1" src="resources/img/main_title_img/home1.png"></div>
                <div class="img s2"><img alt="img2" src="resources/img/main_title_img/home2.png"></div>
                <div class="img s3"><img alt="img3" src="resources/img/main_title_img/home3.png"></div>
                <!--  <div class="img s4"><img alt="img4" src="resources/img/main_title_img/home4.png"></div> -->
            </div>
        </div>
        <div class="slider_dot"><!-- 메인메뉴 현재 사진 이동 버튼 -->
        </div>
    </div>
	
	<div class="chart">
		오늘 판매량 상위 5개 제품
		<canvas id="myChart"></canvas>
	</div>
	
	<script>
		
		window.onload=function(){
			url="chart_select.do";
			param="";
			
			sendRequest(url, param, resultFn, "POST");
		}
		
		function resultFn() {
		    if(xhr.readyState == 4 && xhr.status == 200) {
		        let data = xhr.responseText;
		        let json = (new Function('return ' + data))();
		        
		        const salesArray = [];
		        const productArray = [];

		        json.forEach(item => {
		            salesArray.push(item.sales); // 판매량 배열에 추가
		            productArray.push(item.p_name); // 제품명 배열에 추가
		        });

		        const ctx = document.getElementById('myChart').getContext('2d');

		        const myChart = new Chart(ctx, {
		            type: 'doughnut', // 도넛형 그래프 유형
		            data: {
		                labels: productArray, // 제품명을 레이블로 사용
		                datasets: [{
		                    label: '판매량 상위 5개', // 데이터셋 레이블
		                    data: salesArray, // 실제 데이터 값
		                    backgroundColor: [ // 도넛 배경색 배열
		                        'rgba(255, 99, 132, 0.2)',
		                        'rgba(54, 162, 235, 0.2)',
		                        'rgba(255, 206, 86, 0.2)',
		                        'rgba(75, 192, 192, 0.2)',
		                        'rgba(153, 102, 255, 0.2)'
		                    ],
		                    borderColor: [ // 도넛 테두리 색상 배열
		                        'rgba(255, 99, 132, 1)',
		                        'rgba(54, 162, 235, 1)',
		                        'rgba(255, 206, 86, 1)',
		                        'rgba(75, 192, 192, 1)',
		                        'rgba(153, 102, 255, 1)'
		                    ],
		                    borderWidth: 1 // 도넛 테두리 너비
		                }]
		            },
		            options: {
		                plugins: {
		                    legend: {
		                        position: 'bottom' // 범례 위치를 아래쪽으로 설정
		                    }
		                },
		                scales: {
		                    y: {
		                        display:false // y축 최소값 0부터 시작
		                    }
		                }
		            }
		        });
		    }
		}
		
		</script>

</html>
