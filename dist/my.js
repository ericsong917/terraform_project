document.getElementById("btn").addEventListener("click", change);
document.getElementById("btn2").addEventListener("click", change2);
var input = document.getElementById("input");
var output = document.getElementById("output");
var output2 = document.getElementById("output2");
function request() {
  var text = input.value;
  fetch(
    "https://pnbwrqn4mkyte5ltemwqaeqrni0tuwar.lambda-url.ap-northeast-2.on.aws/?eng_name=" +
      text,
    {
      method: "GET",
    }
  )
    .then((response) => {
      return response.json();
    })
    .then((data) => {
      var result = data["eng_name"];
      if (result == "None") {
        alert("Not in Cds");
        output.innerHTML = "";
      } else {
        output.innerHTML = result;
      }
    });
}
function request2() {
  var text = input.value;
  fetch(
    "https://wr663yxy3fmlmi54gj5kv76j540kkjke.lambda-url.ap-northeast-2.on.aws/?eng_name=" +
      text,
    {
      method: "GET",
    }
  )
    .then((response) => {
      return response.json();
    })
    .then((data) => {
      var result = data["eng_name"];
      if (result == "None") {
        alert("Not in Cds");
        output2.innerHTML = "";
      } else {
        output2.innerHTML = result;
      }
    });
}

function change() {
  var input_var = input.value;
  if (input_var.length > 0) {
    request();
  } else {
    alert("please put any name");
    output.innerHTML = "";
  }
}
function change2() {
  var input_var = input.value;
  if (input_var.length > 0) {
    request2();
  } else {
    alert("please put any name");
    output2.innerHTML = "";
  }
}
