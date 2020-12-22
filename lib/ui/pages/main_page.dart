import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green[700],
          centerTitle: true,
          title: Text(
            "Pengelola Data Pasien Meninggal",
          )),
      body: Container(
        color: Colors.blueGrey[200],
        child: Center(
            child: ListView(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.27),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.16),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.green[500]),
                      child: Center(
                        child: Text(
                          "Tambahkan\nData",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.16),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.green[500]),
                      child: Center(
                        child: Text(
                          "Lihat\nData",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ]),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
            ),
            SizedBox(
              height: 35,
              width: 35,
              child: FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.red,
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
          ],
        )),
      ),
    );
  }
}
