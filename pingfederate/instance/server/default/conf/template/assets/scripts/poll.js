
async function doPoll(code){
    await sleep(2000);
    $.post('/ext/kycstatus', 'code=' + code , function(data) {
        console.log("Current status: " + data.KYCStatus);
        if(data.KYCStatus == "KYC Complete"){
            document.forms[0].submit();
        }
        if(data.KYCStatus == "Pending KYC"){
            document.forms[0].submit();
        }
        setTimeout(doPoll(code),30000);
    });
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}