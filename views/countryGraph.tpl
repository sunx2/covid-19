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
      #totalCases {
        text-align: center;
        font-family: "Roboto", sans-serif;
        width: 99%;
        color: white;
        position: absolute;
        top: -1%;
      }
    </style>
  </head>
  <body>
    <h1 id="CountryName"></h1>
    <h4 id="totalCases">Total Cases: <span id="numberOfTotalCases"></span></h4>
    <div style="position: relative; margin: auto; height: 100%; width: 100%;">
      <canvas id="myChart"></canvas>
    </div>
  </body>
  <script>
    var datalist = JSON.parse("{{datalist}}".replace(/&#039;/g, '"'));
    document.getElementById("CountryName").innerHTML = datalist.country;
    document.getElementById("numberOfTotalCases").innerHTML = ""; //Change this to total cases
    var ctx = document.getElementById("myChart").getContext("2d");
    var myChart = new Chart(ctx, {
      type: "line",
      data: {
        labels: datalist.x, //X AXIS
        datasets: [
          {
            label: "# of cases",
            data: datalist.y, //Y AXIS
            backgroundColor: Array(datalist.length).fill(
              "rgba(255, 99, 132, 0.2)"
            ),
            borderColor: Array(datalist.length).fill("rgba(255, 99, 132, 1)"),
            borderWidth: 1,
            order: 1,
          },
          {
            label: "# of recoveries",
            data: datalist.y, //CHANGE THIS TO RECOVERY DATASET
            backgroundColor: Array(datalist.length).fill(
              "rgba(107, 107, 255, 0.2)"
            ),
            borderColor: Array(datalist.length).fill("rgba(107, 107, 255, 1)"),
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
