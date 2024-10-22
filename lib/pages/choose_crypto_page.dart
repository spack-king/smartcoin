import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseCryptoPage extends StatefulWidget {
  final title;
  const ChooseCryptoPage({super.key,required this.title});

  @override
  State<ChooseCryptoPage> createState() => _ChooseCryptoPageState();
}

class _ChooseCryptoPageState extends State<ChooseCryptoPage> {
  String selectedExchange = '';
  String selectedCrypto  = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: widget.title == 'exchange'
            ?Exchange()
          : Currency(),

        ),
      ),
    );
  }

  Exchange() {
   return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //close button
        Container(
          margin: EdgeInsets.all(10),
          child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.close)),
        ),
        //binance
        ListTile(
          onTap: (){
            selectExchange('Binance');
          },
          leading: Logo('assets/binance.jpg'),
          title: Text('Binance', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectExchange('Binance');

            },
            icon: Icon(selectedExchange == 'Binance' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //bybit
        ListTile(
          onTap: (){

            selectExchange('Bybit');
          },
          leading: Logo('assets/bybit.jpg'),
          title: Text('Bybit', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectExchange('Bybit');
            },
            icon: Icon(selectedExchange == 'Bybit' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //okx
        ListTile(
          onTap: (){
            selectExchange('Okx');

          },
          leading: Logo('assets/okx.jpg'),
          title: Text('OKX', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectExchange('Okx');
            },
            icon: Icon(selectedExchange == 'Okx' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //bingX
        ListTile(
          onTap: (){
            selectExchange('Bingx');
          },
          leading: Logo('assets/bingx.jpg'),
          title: Text('BingX', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectExchange('Bingx');

            },
            icon: Icon(selectedExchange == 'Bingx' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //HTX
        ListTile(
          onTap: (){
            selectExchange('HTX');

          },
          leading: Logo('assets/htx.jpg'),
          title: Text('HTX', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectExchange('HTX');

            },
            icon: Icon(selectedExchange == 'HTX' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //Kucoin
        ListTile(
          onTap: (){
            selectExchange('Kucoin');
          },
          leading: Logo('assets/kucoin.jpg'),
          title: Text('Kucoin', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectExchange('Kucoin');

            },
            icon: Icon(selectedExchange == 'Kucoin' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //Gate.io
        ListTile(
          onTap: (){
            selectExchange('Gate.io');
          },
          leading: Logo('assets/gate.jpg'),
          title: Text('Gate.io', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectExchange('Gate.io');

            },
            icon: Icon(selectedExchange == 'Gate.io' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //MEXC
        ListTile(
          onTap: (){
            selectExchange('MEXC');

          },
          leading: Logo('assets/mexc.jpg'),
          title: Text('MEXC', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectExchange('MEXC');

            },
            icon: Icon(selectedExchange == 'MEXC' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //Bitget
        ListTile(
          onTap: (){
            selectExchange('Bitget');

          },
          leading: Logo('assets/bitget.jpg'),
          title: Text('Bitget', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectExchange('Bitget');

            },
            icon: Icon(selectedExchange == 'Bitget' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        const SizedBox(height: 10,),
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('Done'))
      ],
    );
  }
  selectExchange(String name) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('exchange', name);
    selectedExchange = name;
    setState(() {

    });
  }
  selectCrypto(String name) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('crypto', name);
    selectedCrypto = name;
    setState(() {

    });
  }

  Currency() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //close button
        Container(
          margin: EdgeInsets.all(10),
          child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.close)),
        ),
        //BabyDodge
        ListTile(
          onTap: (){
            selectCrypto('BabyDodge');
          },
          title: Text('BabyDodge', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectCrypto('BabyDodge');

            },
            icon: Icon(selectedCrypto == 'BabyDodge' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //bitcoin
        ListTile(
          onTap: (){
            selectCrypto('Bitcoin');
          },
          title: Text('Bitcoin', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectCrypto('Bitcoin');

            },
            icon: Icon(selectedCrypto == 'Bitcoin' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //BNB
        ListTile(
          onTap: (){
            selectCrypto('BNB');
          },
          title: Text('BNB', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectCrypto('BNB');

            },
            icon: Icon(selectedCrypto == 'BNB' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //ETHEREUM
        ListTile(
          onTap: (){
            selectCrypto('ETHEREUM');
          },
          title: Text('ETHEREUM', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectCrypto('ETHEREUM');

            },
            icon: Icon(selectedCrypto == 'ETHEREUM' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //Floki
        ListTile(
          onTap: (){
            selectCrypto('Floki');
          },
          title: Text('Floki', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectCrypto('Floki');

            },
            icon: Icon(selectedCrypto == 'Floki' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //Ginux
        ListTile(
          onTap: (){
            selectCrypto('Ginux');
          },
          title: Text('Ginux', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectCrypto('Ginux');

            },
            icon: Icon(selectedCrypto == 'Ginux' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //Solana
        ListTile(
          onTap: (){
            selectCrypto('Solana');
          },
          title: Text('Solana', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectCrypto('Solana');

            },
            icon: Icon(selectedCrypto == 'Solana' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //Wen
        ListTile(
          onTap: (){
            selectCrypto('Wen');
          },
          title: Text('Wen', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectCrypto('Wen');

            },
            icon: Icon(selectedCrypto == 'Wen' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //Notcoin
        ListTile(
          onTap: (){
            selectCrypto('Notcoin');
          },
          title: Text('Notcoin', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectCrypto('Notcoin');

            },
            icon: Icon(selectedCrypto == 'Notcoin' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //onchain
        ListTile(
          onTap: (){
            selectCrypto('Onchain');
          },
          title: Text('Onchain', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectCrypto('Onchain');

            },
            icon: Icon(selectedCrypto == 'Onchain' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //Pitbull
        ListTile(
          onTap: (){
            selectCrypto('Pitbull');
          },
          title: Text('Pitbull', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectCrypto('Pitbull');

            },
            icon: Icon(selectedCrypto == 'Pitbull' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),
        //Brise
        ListTile(
          onTap: (){
            selectCrypto('Brise');
          },
          title: Text('Brise', textScaleFactor: 1.5,),
          trailing: IconButton(
            onPressed: (){
              selectCrypto('Brise');

            },
            icon: Icon(selectedCrypto == 'Brise' ? Icons.radio_button_checked_outlined : Icons.radio_button_off),
          ),
        ),

        const SizedBox(height: 10,),
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('Done'))
      ],
    );
  }

  Logo(String image){
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      
      child: Image.asset(image, width: 50, height: 50,),
    );
  }
}
