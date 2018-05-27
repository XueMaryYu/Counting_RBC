// subfolders in that folder. In this example, it runs the Subtract 
// Background command of TIFF files. For other kinds of processing,
// edit the processFile() function at the end of this macro.

   requires("1.33s"); 
   dir = getDirectory("Choose a Directory ");
   setBatchMode(true);
   count = 0;
   countFiles(dir);
   n = 0;
   processFiles(dir);
   //print(count+" files processed");
   
   function countFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              countFiles(""+dir+list[i]);
          else
              count++;
      }
  }

   function processFiles(dir) {
      list = getFileList(dir);
      for (i=0; i<list.length; i++) {
          if (endsWith(list[i], "/"))
              processFiles(""+dir+list[i]);
          else {
             showProgress(n++, count);
             path = dir+list[i];
             processFile(path);
          }
      }
  }
  //setBatchMode(true);
  function processFile(path) {
       if (endsWith(path, ".jpg")) {
           open(path);
           run("8-bit");
           setAutoThreshold("Default");
		   setOption("BlackBackground", false);
		   run("Convert to Mask");
           run("Fill Holes");
           run("Watershed");
           run("Analyze Particles...", "size=1500-Infinity summarize");
           //run("Close");  
           //name=getTitle;
           //IJ.renameResults(name); 
           //setResult("name", rowNumber, value) 
       }
  }