<html>
  <head>
    <script src="{{ url('res', filepath='js/d3.min.js') }}"></script>
    <script src="{{ url('res', filepath='js/topojson.min.js') }}"></script>
    <script src="{{ url('res', filepath='js/datamaps.world.min.js') }}"></script>
    <link
      href="https://fonts.googleapis.com/css?family=Roboto&display=swap"
      rel="stylesheet"
    />
    <title>Covid-19 - Report</title>
    <style>
      html {
        background-color: #000000;
        background-image: url("{{ url('res', filepath='images/bg.png') }}");
        overflow: hidden;
      }
      #worldMap {
        width: 100%;
        height: 100%;
        margin: auto;
        aspect-ratio: 1.777777777777778;
        opacity: 80%;
        animation: introMap 2s;
        transform: scale(1, 1.1); /* To cure my OCD */
        z-index: 1;
        overflow: hidden;
        display: flex;
        align-items: center;
        justify-content: center;
        transform: translate(0%, -5%);
        object-fit: cover;
      }
      #mainHeaderFirst {
        font-family: "Roboto", sans-serif;
        color: white;
        font-size: 30px;
        animation: introHeader 2s forwards;
        letter-spacing: 1px;
        vertical-align: middle;
        transform: translate(0%, 800%);
        pointer-events: none;
      }
      .popup {
        background: white;
        font-size: small;
      }
      #headerWrapper {
        position: fixed;
        text-align: center;
        height: 101%;
        width: 101%;
        animation: headerBG 2s forwards;
        margin: 0;
        background-color: black;
        z-index: 2;
        pointer-events: none;
        left: -1%;
        top: -1%;
      }
      @keyframes headerBG {
        60% {
          opacity: 100%;
        }
        100% {
          opacity: 0%;
        }
      }

      @keyframes introHeader {
        from {
          letter-spacing: 5px;
          opacity: 0%;
        }
        40% {
          letter-spacing: 1px;
          opacity: 100%;
        }
        60% {
          letter-spacing: 1px;
          opacity: 100%;
        }
        100% {
          letter-spacing: 5px;
          opacity: 0%;
        }
      }
      @keyframes introMap {
        from {
          opacity: 0%;
        }
        to {
          opacity: 80%;
        }
      }
      #stats {
        position: absolute;
        flex-direction: row;
        color: white;
        font-family: "Roboto", sans-serif;
        line-height: 2px;
        opacity: 80%;
      }
      #time {
        color: white;
        font-family: "Roboto", sans-serif;
        opacity: 80%;
      }
      @media (orientation: portrait) and (max-width: 800px) {
        #mainHeaderFirst {
          animation: introMap 1s;
        }
      }
    </style>
  </head>
  <body onload="startTime()">
    <div id="headerWrapper">
      <h1 id="mainHeaderFirst">World Map (affected regions)</h1>
    </div>
    <div id="stats">
      <h3 id="time"></h3>
      <p class="stats" style="font-size: xx-large;">
        Total Cases: <span id="totinf"></span>
      </p>
      <p class="stats">
        Total <span style="color: rgb(255, 118, 118);">Deaths</span>:
        <span id="totded"></span>
      </p>
      <p class="stats">
        Total <span style="color: rgb(141, 255, 118);">Recoveries</span>:
        <span id="totrec"></span>
      </p>
    </div>
    <div id="worldMap"></div>
  </body>
  <script>
    var datalist = JSON.parse("{{datalist}}".replace(/&#039;/g, '"'));
    document.getElementById("totinf").innerHTML = datalist.all_cases;
    document.getElementById("totded").innerHTML = datalist.all_deaths;
    document.getElementById("totrec").innerHTML = datalist.all_recovered;
    var map = new Datamap({
      responsive: true,
      element: document.getElementById("worldMap"),
      fills: {
        HIGH: "#0F2A45",
        LOW: "#1c60a0",
        MEDIUM: "#2f87e0",
        VERYLOW: "#409cd6",
        UNKNOWN: "rgb(0,0,0)",
        defaultFill: "#080808",
      },
      data: datalist,
      done: function (datamap) {
        datamap.svg
          .selectAll(".datamaps-subunit")
          .on("click", function (geography) {
            window.location.assign(
              "/country/" + geography.properties.name.toLowerCase()
            ); //Use this to open chart page
          });
      },
      geographyConfig: {
        popupTemplate: function (geo, data) {
          return `<div class="popup" style="padding: 5px; border-radius: 5px; opacity: 90%;">
           <p><strong>${geo.properties.name}</p>
          Total Cases : <font color = "blue"> <strong> ${data.cases} </strong> </font> <br>
          Total Recovered: <font color = "green"> <strong> ${data.recovered} </strong> </font> <br>
          Total Deaths: <font color = "red"> <strong> ${data.deaths} </strong> </font>
          
          </div>`;
        },
      },
    });
    window.addEventListener("resize", function () {
      map.resize();
    });
    function startTime() {
      var today = new Date();
      var h = today.getHours();
      var m = today.getMinutes();
      var s = today.getSeconds();
      m = checkTime(m);
      s = checkTime(s);
      document.getElementById("time").innerHTML = h + ":" + m + ":" + s;
      var t = setTimeout(startTime, 500);
    }
    function checkTime(i) {
      if (i < 10) {
        i = "0" + i;
      } // add zero in front of numbers < 10
      return i;
    }
  </script>
</html>
