<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
		<script>
			function send(){
				
			}
		
		</script>
	</head>
	
	<body>
		여기 들어와야 는데 왜 크기조절 안되냐
		<!-- canvas : 차트 그리고 + 크기 조절 -->
		<canvas id="myChart" width="1000" height="100"></canvas>
		<script>
		
		//ajax혹은 fetch사용해야 json사용할 수 있음. 나중에 관리자 페이지 받으면 수정바람
		console.log("들어옴");
		const ctx = document.getElementById('myChart').getContext('2d');
		//2D그래픽 컨텍스트 가져옴
		
		const p_list = ${list}
		let list = (new Function('return ' + data))();
		alert("durl : " + list);
		
		const salesArray = [];
		const productArray = [];
		
		list.forEach(item => {
			salesArray.push(item.sales);
			productArray.push(item.p_name);
		});
		
		console.log("Sales Array:", salesArray);
		console.log("Product Array:", productArray);
		
		
		
		const myChart = new Chart(ctx, {//ctx : 위의 2D 컨텍스트. 새로운 차트 생성함
		    type: 'bar', // 유형 : 막대 그래프
		    data: { //data : 데이터 및 관련 설정들
		        labels: productArray, //각 막대 레이블 정의(분류명)
		        datasets: [{ //datasets: 데이터 세트 배열로, 각 데이터 세트의 레이블, 데이터 값, 배경색, 테두리 색상 등을 정의합니다.
		            label: '판매량 상위 5개', //label: 데이터 세트의 이름을 정의합니다.
		            data: salesArray, //실제 값 배열로 정의함
		            backgroundColor: [ // 막대의 배경색
		                'rgba(255, 99, 132, 0.2)',
		                'rgba(54, 162, 235, 0.2)',
		                'rgba(255, 206, 86, 0.2)',
		                'rgba(75, 192, 192, 0.2)',
		                'rgba(153, 102, 255, 0.2)',
		                'rgba(255, 159, 64, 0.2)'
		            ],
		            borderColor: [ //막대의 테두리 색
		                'rgba(255, 99, 132, 1)',
		                'rgba(54, 162, 235, 1)',
		                'rgba(255, 206, 86, 1)',
		                'rgba(75, 192, 192, 1)',
		                'rgba(153, 102, 255, 1)',
		                'rgba(255, 159, 64, 1)'
		            ],
		            borderWidth: 1 // 테두리 너비
		        }]
		    },
		    options: { // 차트 옵션
		        scales: {
		            y: { // scales 객체 내 y축 변경함
		                beginAtZero: true // y축 최소값 =0
		            }
		        }
		    }
		});
		</script>
	</body>
</html>