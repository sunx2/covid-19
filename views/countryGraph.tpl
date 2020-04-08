<html>
  <head>
    <script src="{{ url('res', filepath='js/Chart.js') }}"></script>
    <!-- ^^ REPLACE THIS WITH PATH TO Chart.js -->
    <link
      href="https://fonts.googleapis.com/css?family=Roboto&display=swap"
      rel="stylesheet"
    />
    <style>
      html {
        background-color: black;
        overflow: hidden;
      }
      #myChart {
        transform: scale(0.8, 0.8);
        background-color: black;
      }
      #countryName {
        text-align: center;
        font-family: "Roboto", sans-serif;
        width: 99%;
        color: white;
        padding-top: 10px;
        position: absolute;
      }
      #countryInfo {
        text-align: center;
        font-family: "Roboto", sans-serif;
        width: 100%;
        position: relative;
        color: white;
        transform: translate(0px, -50px);
        opacity: 80%;
      }
    </style>
  </head>
  <body>
    <h1 id="CountryName"></h1>
    <div style="position: relative; margin: auto; height: 100%; width: 100%;">
      <canvas id="myChart"></canvas>
    </div>
    <div id="countryInfo">
      <span>Total Cases: <span id="numberOfTotalCases"></span></span>
      <span>, Total Deaths: <span id="numberOfTotalDeaths"></span></span>
      <span
        >, Total Recoveries: <span id="numberOfTotalRecoveries"></span
      ></span>
      <span>, Cases Today: <span id="CasesToday"></span></span>
      <span>, Deaths Today: <span id="DeathsToday"></span></span>
    </div>
  </body>
  <script>
    var datalist = JSON.parse("{{datalist}}".replace(/&#039;/g, '"'));
    document.getElementById("CountryName").innerHTML = datalist.country;
    document.getElementById("numberOfTotalCases").innerHTML =
      datalist.total_cases; //Change this to total cases
    var ctx = document.getElementById("myChart").getContext("2d");
    Chart.defaults.global.defaultFontSize = 23;
    Chart.defaults.global.elements.point.radius = 5;
    Chart.defaults.global.elements.point.hoverRadius = 7;
    var myChart = new Chart(ctx, {
      type: "line",
      data: {
        labels: datalist.dates, //X AXIS
        datasets: [
          {
            label: "Cases",
            data: datalist.cases, //Y AXIS
            backgroundColor: Array(datalist.length).fill(
              "rgba(48, 90, 242, 0.2)"
            ),
            borderColor: Array(datalist.length).fill("rgba(48, 90, 242, 1)"),
            borderWidth: 1,
            order: 3,
          },
          {
            label: "Recoveries",
            data: datalist.recovered, //CHANGE THIS TO RECOVERY DATASET
            backgroundColor: Array(datalist.length).fill(
              "rgba(50, 205, 50, 0.2)"
            ),
            borderColor: Array(datalist.length).fill("rgba(50, 205, 50, 1)"),
            borderWidth: 1,
            order: 2,
          },
          {
            label: "Deaths",
            data: datalist.deaths, //Y AXIS
            backgroundColor: Array(datalist.length).fill(
              "rgba(255, 0, 0, 0.2)"
            ),
            borderColor: Array(datalist.length).fill("rgba(255, 0, 0, 1)"),
            borderWidth: 1,
            order: 1,
          },
        ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        responsiveAnimationDuration: 1,
        scales: {
          scaleLabel: {
            fontSize: 15,
          },
          yAxes: [
            {
              ticks: {
                beginAtZero: false,
              },
              gridLines: {
                display: true,
                color: "rgba(255,99,132,0.2)",
              },
            },
          ],
        },
      },
    });
    Chart.defaults.global.defaultFontFamily = "Roboto";
    window.addEventListener("resize", function () {
      myChart.resize();
    });
  </script>
</html>
