@ECHO OFF 
  SET /P Filelocation=Please Enter Location: 
 
  mkdir %Filelocation%OUTPUT 
 
  :: Code to check for presence of Comments 
  grep -H -i -n -e "//" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_comment.txt" 
  type -H -i  "%Filelocation%*.java" |gawk "//*/,/*//" >>
  "%Filelocation%OUTPUTMultilineComments.txt" 
  grep -H -i -n -v "TODO" "%Filelocation%OUTPUTTemp_comment.txt" >> 
  "%Filelocation%OUTPUTSinglelineComments.txt"
  del %Filelocation%OUTPUTTemp_comment.txt 
 
  :: Code to check for insecure usage of SharedPreferences 
  grep -H -i -n -C2 -e "putString" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTverify_sharedpreferences.txt" 
  grep -H -i -n -C2 -e "MODE_PRIVATE" "%Filelocation%*.java" >> "%Filelocation%OUTPUTModeprivate.txt" 
  grep -H -i -n -C2 -e "MODE_WORLD_READABLE" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTWorldreadable.txt" 
  grep -H -i -n -C2 -e "MODE_WORLD_WRITEABLE" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTWorldwritable.txt" 
  grep -H -i -n -C2 -e "addPreferencesFromResource" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTverify_sharedpreferences.txt" 
 
  :: Code to check for possible TapJacking attack 
  grep -H -i -n -e filterTouchesWhenObscured="true" "%Filelocation%........reslayout*.xml" >>
  "%Filelocation%OUTPUTTemp_tapjacking.txt" 
  grep -H -i -n -e "<Button" "%Filelocation%........reslayout*.xml" >>
  "%Filelocation%OUTPUTtapjackings.txt"  
  grep -H -i -n -v filterTouchesWhenObscured="true" "%Filelocation%OUTPUTtapjackings.txt" >>
  "%Filelocation%OUTPUTTemp_tapjacking.txt" 
  del %Filelocation%OUTPUTTemp_tapjacking.txt 
 
  :: Code to check usage of external storage card for storing information 
  grep -H -i -n  -e "WRITE_EXTERNAL_STORAGE" "%Filelocation%........AndroidManifest.xml" >>
  "%Filelocation%OUTPUTSdcardStorage.txt"   
  grep -H -i -n  -e "getExternalStorageDirectory()" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTSdcardStorage.txt"
  grep -H -i -n  -e "sdcard" "%Filelocation%*.java" >> "%Filelocation%OUTPUTSdcardStorage.txt" 
 
  :: Code to check for possible scripting javscript injection 
  grep -H -i -n  -e "addJavascriptInterface()" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTTemp_probableXss.txt" 
  grep -H -i -n  -e "setJavaScriptEnabled(true)" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTTemp_probableXss.txt" 
  grep -H -i -n -v "import" "%Filelocation%OUTPUTTemp_probableXss.txt" >>
  "%Filelocation%OUTPUTprobableXss.txt" 
  del %Filelocation%OUTPUTTemp_probableXss.txt 
 
  :: Code to check for presence of possible weak algorithms 
  grep -H -i -n  -e "MD5" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_weakencryption.txt" 
  grep -H -i -n  -e "base64" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_weakencryption.txt" 
  grep -H -i -n  -e "des" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_weakencryption.txt" 
  grep -H -i -n  -v "import" "%Filelocation%OUTPUTTemp_weakencryption.txt" >>
  "%Filelocation%OUTPUTWeakencryption.txt" 
  del %Filelocation%OUTPUTTemp_weakencryption.txt 
 
  :: Code to check for weak transportation medium 
  grep -H -i -n -C3  "http://" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_overhttp.txt" 
  grep -H -i -n -C3 -e "HttpURLConnection" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTTemp_overhttp.txt" 
  grep -H -i -n -C3 -e "URLConnection" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTTemp_OtherUrlConnection.txt" 
  grep -H -i -n -C3 -e "URL" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTTemp_OtherUrlConnection.txt" 
  grep -H -i -n  -e "TrustAllSSLSocket-Factory" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTBypassSSLvalidations.txt" 
  grep -H -i -n -e "AllTrustSSLSocketFactory" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTBypassSSLvalidations.txt" 
  grep -H -i -n -e "NonValidatingSSLSocketFactory" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTBypassSSLvalidations.txt"  
  grep -H -i -n  -v "import" "%Filelocation%OUTPUTTemp_OtherUrlConnection.txt" >>
  "%Filelocation%OUTPUTOtherUrlConnections.txt" 
  del %Filelocation%OUTPUTTemp_OtherUrlConnection.txt 
  grep -H -i -n  -v "import" "%Filelocation%OUTPUTTemp_overhttp.txt" >> 
  "%Filelocation%OUTPUTUnencryptedTransport.txt" 
  del %Filelocation%OUTPUTTemp_overhttp.txt 
 
 
  :: Code to check for Autocomplete ON 
  grep -H -i -n -e "<Input" "%Filelocation%........reslayout*.xml" >>
  "%Filelocation%OUTPUTTemp_autocomp.txt"  
  grep -H -i -n -v "textNoSuggestions" "%Filelocation%OUTPUTTemp_autocomp.txt" >>
  "%Filelocation%OUTPUTAutocompleteOn.txt" 
  del %Filelocation%OUTPUTTemp_autocomp.txt 
 
 
  :: Code to presence of possible SQL Content 
  grep -H -i -n  -e "rawQuery" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_sqlcontent.txt"  
  grep -H -i -n  -e "compileStatement" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTTemp_sqlcontent.txt"  
  grep -H -i -n  -e "db" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_sqlcontent.txt"  
  grep -H -i -n  -e "sqlite" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_sqlcontent.txt"  
  grep -H -i -n  -e "database" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_sqlcontent.txt"  
  grep -H -i -n  -e "insert" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_sqlcontent.txt"  
  grep -H -i -n -e "delete" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_sqlcontent.txt"  
  grep -H -i -n  -e "select" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_sqlcontent.txt"  
  grep -H -i -n  -e "table" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_sqlcontent.txt"  
  grep -H -i -n -e "cursor" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_sqlcontent.txt"  
  grep -H -i -n -v "import" "%Filelocation%OUTPUTTemp_sqlcontent.txt" >>
  "%Filelocation%OUTPUTSqlcontents.txt" 
  del %Filelocation%OUTPUTTemp_sqlcontent.txt 
 
  :: Code to check for Logging mechanism 
  grep -H -i -n  -F "Log." "%Filelocation%*.java" >> "%Filelocation%OUTPUTLogging.txt"  
 
  :: Code to check for Information in Toast messages 
  grep -H -i -n -e "Toast.makeText" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_Toast.txt"  
  grep -H -i -n -v "//" "%Filelocation%OUTPUTTemp_Toast.txt" >>
  "%Filelocation%OUTPUTToast_content.txt" 
  del %Filelocation%OUTPUTTemp_Toast.txt 
 
  :: Code to check for Debugging status 
  grep -H -i -n  -e "android:debuggable" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTDebuggingAllowed.txt"  
 
  :: Code to check for presence of Device Identifiers 
  grep -H -i -n  -e "uid|user-id|imei|deviceId|deviceSerialNumber|devicePrint|X-DSN|phone
  |mdn|did|IMSI|uuid" "%Filelocation%*.java" >> "%Filelocation%OUTPUTTemp_Identifiers.txt"  
  grep -H -i -n -v "//" "%Filelocation%OUTPUTTemp_Identifiers.txt" >>
  "%Filelocation%OUTPUTDevice_Identifier.txt" 
 del %Filelocation%OUTPUTTemp_Identifiers.txt 
 
  :: Code to check for presence of Location Info 
  grep -H -i -n  -e "getLastKnownLocation()|requestLocationUpdates()|getLatitude()|getLongitude()
  |LOCATION" "%Filelocation%*.java" >> "%Filelocation%OUTPUTLocationInfo.txt"  
 
  :: Code to check for possible Intent Injection 
  grep -H -i -n -C3 -e "Action.getIntent(" "%Filelocation%*.java" >>
  "%Filelocation%OUTPUTIntentValidation.txt"
