<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
		<script src="/store/resources/js/httpRequest.js"></script>
	</head>
	
	<body>
		여기 들어와야 는데 왜 크기조절 안되냐
		<!-- canvas : 차트 그리고 + 크기 조절 -->
		<canvas id="myChart" width="50" height="30"></canvas>
		<script>
		
		window.onload=function(){
			url="chart_select.do";
			param="";
			
			sendRequest(url, param, resultFn, "POST");
		}
		
		function resultFn(){
		    if(xhr.readyState == 4 && xhr.status == 200){
		        //alert("json ; "+json);//데이터 들어옴...ㅜㅜ
		        let data = xhr.responseText;
		        let json = (new Function('return '+data))();
		       	
				//왜된거지???
		        
		       const salesArray = [];
		       const productArray = [];

		        json.forEach(item => {
		            salesArray.push(item.sales); // 판매량 배열에 추가
		            productArray.push(item.p_name); // 제품명 배열에 추가
		        });

		        
		        const ctx = document.getElementById('myChart').getContext('2d');

		        const myChart = new Chart(ctx, {
		            type: 'bar', // 막대 그래프 유형
		            data: {
		                labels: productArray, // 제품명을 레이블로 사용
		                datasets: [{
		                    label: '판매량 상위 5개', // 데이터셋 레이블
		                    data: salesArray, // 실제 데이터 값
		                    backgroundColor: [ // 막대 배경색 배열
		                        'rgba(255, 99, 132, 0.2)',
		                        'rgba(54, 162, 235, 0.2)',
		                        'rgba(255, 206, 86, 0.2)',
		                        'rgba(75, 192, 192, 0.2)',
		                        'rgba(153, 102, 255, 0.2)'
		                        //,'rgba(255, 159, 64, 0.2)'
		                    ],
		                    borderColor: [ // 막대 테두리 색상 배열
		                        'rgba(255, 99, 132, 1)',
		                        'rgba(54, 162, 235, 1)',
		                        'rgba(255, 206, 86, 1)',
		                        'rgba(75, 192, 192, 1)',
		                        'rgba(153, 102, 255, 1)'
		                        //,'rgba(255, 159, 64, 1)'
		                    ],
		                    borderWidth: 1 // 막대 테두리 너비
		                }]
		            },
		            options: {
		                scales: {
		                    y: {
		                        beginAtZero: true // y축 최소값 0부터 시작
		                    }
		                }
		            }
		        }); // 이 부분이 누락되었던 부분입니다.
		    }
		    
		}//if문
		
		
		</script>
	</body>
</html>