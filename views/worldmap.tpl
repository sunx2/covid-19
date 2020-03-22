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
      }
      #worldMap {
        position: fixed;
        height: 95%;
        width: 100%;
        margin: auto;
        aspect-ratio: 1.777777777777778;
        opacity: 80%;
        animation: introHeader 3s;
        transform: scale(1, 1.1); /* To cure my OCD */
        z-index: 1;
        transform: translate(0%, 5%);
      }
      #mainHeaderFirst {
        font-family: "Roboto", sans-serif;
        color: white;
        font-size: 30px;
        animation: introHeader 5s forwards;
        letter-spacing: 1px;
        vertical-align: middle;
        transform: translate(0%, 1000%);
        pointer-events: none;
      }
      .popup {
        background: white;
        font-size: small;
      }
      #headerWrapper {
        position: fixed;
        text-align: center;
        height: 99%;
        width: 100%;
        animation: headerBG 5s forwards;
        margin: auto;
        background-color: black;
        z-index: 2;
        pointer-events: none;
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
    </style>
  </head>
  <body>
    <div id="headerWrapper">
      <h1 id="mainHeaderFirst">World Map (affected regions)</h1>
    </div>
    <div id="worldMap"></div>
  </body>
  <script>
   var datalist = JSON.parse("{{datalist}}".replace(/&#039;/g,'"'))
    var map = new Datamap({
      element: document.getElementById("worldMap"),
      fills: {
        HIGH: "#afafaf",
        LOW: "#123456",
        MEDIUM: "#009ddc",
        UNKNOWN: "rgb(0,0,0)",
        defaultFill: "#080808"
      },
      data : datalist,
      geographyConfig: {
            popupTemplate: function(geo, data) {

                return `<div class="popup"><strong>${geo.properties.name}</strong><hr style="color:red">total <span style="color:blue">${window.location.pathname.split('/')[2]}</span> : ${data.numberOfThings}</div>`
            }
        }
    });
  </script>
</html>
