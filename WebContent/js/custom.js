 var rowIndex = 1;
 function addFile(){
     if(rowIndex > (10)) return false;
     var oCurrentRow,oCurrentCell;
     var sAddingHtml;
     oCurrentRow = insertTable.insertRow();
     rowIndex = oCurrentRow.rowIndex;
     oCurrentCell = oCurrentRow.insertCell();
     rowIndex++;
     oCurrentCell.innerHTML = "<tr><td><input  TYPE=FILE NAME='filename" +rowIndex + "' ></td></tr>";
     form.rowCount.value = rowIndex;
     
     if(rowIndex == 6)
    	 {
    	 document.getElementById('insertTable').deleteRow(5);

    	
    	 }
 }
