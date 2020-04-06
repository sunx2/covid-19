<html>
  <head>
    <script src="\res\js\chart.js"></script>
    <!-- ^^ REPLACE THIS WITH PATH TO Chart.js -->
    <link
      href="https://fonts.googleapis.com/css?family=Roboto&display=swap"
      rel="stylesheet"
    />
    <style>
      html {
        background-color: black;
      }
      #myChart {
        transform: scale(0.75, 0.75);
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
    </style>
  </head>
  <body>
    <h1 id="CountryName"></h1>
    <div
      style="position: relative;
    margin: auto;
    height: 100%;
    width: 100%;"
    >
      <canvas id="myChart"></canvas>
    </div>
  </body>
  <script>
    var datalist = JSON.parse("{{datalist}}".replace(/&#039;/g,'"'))
    document.getElementById("CountryName").innerHTML = datalist.country; //Change this to country name
    var ctx = document.getElementById("myChart").getContext("2d");
    var myChart = new Chart(ctx, {
      type: "line",
      data: {
        labels: datalist.x, //X AXIS
        datasets: [
          {
            label: "# of cases",
            data: datalist.y, //Y AXIS
            backgroundColor: Array(datalist.length).fill("rgba(255, 99, 132, 0.2)")
            //   "rgba(255, 99, 132, 0.2)", //just make sure that the number of lines here match the number of values
            //   "rgba(255, 99, 132, 0.2)",
            //   "rgba(255, 99, 132, 0.2)",
            //   "rgba(255, 99, 132, 0.2)",
            //   "rgba(255, 99, 132, 0.2)",
            //   "rgba(255, 99, 132, 0.2)"
            ,
            borderColor: Array(datalist.length).fill("rgba(255, 99, 132, 1)")
            //   "rgba(255, 99, 132, 1)", //just make sure that the number of lines here match the number of values
            //   "rgba(255, 99, 132, 1)",
            //   "rgba(255, 99, 132, 1)",
            //   "rgba(255, 99, 132, 1)",
            //   "rgba(255, 99, 132, 1)",
            //   "rgba(255, 99, 132, 1)"
            ,
            borderWidth: 1
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        responsiveAnimationDuration: 1,
        scales: {
          yAxes: [
            {
              ticks: {
                beginAtZero: true
              },
              gridLines: {
                display: true,
                color: "rgba(255,99,132,0.2)"
              }
            }
          ]
        }
      }
    });
    Chart.defaults.global.defaultFontSize = "20";
    window.addEventListener("resize", function() {
      myChart.resize();
    });
  </script>
</html>