import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_speaker/speakerScreen.dart';
import 'package:pdf_text/pdf_text.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PDFDoc _pdfDoc;
  String _text = "";
  String path = "";
  bool _buttonsEnabled = true;

  _setPDFDoc() async {
    _pdfDoc = await PDFDoc.fromPath(path);
  }
  _pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf']
    );
    if(result != null) {
      setState(() {
        path = result.files.single.path;
        _setPDFDoc();
      });
    }
  }
  _readRandomPage() async {

    if (_pdfDoc == null) {
      return;
    }
    setState(() {
      _buttonsEnabled = false;
    });
    String text = await _pdfDoc.pageAt(Random().nextInt(_pdfDoc.length) + 1).text;
    setState(() {
      _text = text;
      _buttonsEnabled = true;
    });
  }
  _readWholeDoc() async {

    if (_pdfDoc == null) {
      return;
    }
    setState(() {
      _buttonsEnabled = false;
    });
    String text = await _pdfDoc.text;
    setState(() {
      _text = text;
      _buttonsEnabled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pdf speaker'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: [
            TextButton(
              child: Text(
                "Pick PDF document",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                  padding: EdgeInsets.all(5),
                  backgroundColor: Colors.blueAccent),
              onPressed: _pickFile,
            ),
            TextButton(
              child: Text(
                "Read random page",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                  padding: EdgeInsets.all(5),
                  backgroundColor: Colors.blueAccent),
              onPressed: _buttonsEnabled ? _readRandomPage : () {},
            ),
            TextButton(
              child: Text(
                "Read whole document",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                  padding: EdgeInsets.all(5),
                  backgroundColor: Colors.blueAccent),
              onPressed: _buttonsEnabled ? _readWholeDoc : () {},
            ),
            TextButton(
              child: Text(
                "Speaker",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                  padding: EdgeInsets.all(5),
                  backgroundColor: Colors.blueAccent),
              onPressed: ()=>{
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> SpeakerScreen(text: _text,)))
              },
            ),
            Padding(
              child: Text(

                _pdfDoc == null
                    ? "Pick a new PDF document and wait for it to load..."
                    : "PDF document loaded, ${_pdfDoc.length} pages\n",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(15),
            ),
            Padding(
              child: Text(
                _text == "" ? "" : "Text:",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.all(15),
            ),
            Text(_text),
          ],
        ),
      ),
    );
  }
}
