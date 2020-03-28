import 'package:flutter/material.dart';

class CheckboxWidget extends StatefulWidget {
  final String texto;
  var data;
  CheckboxWidget(this.texto);
  @override
  _CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  var _bandera = false;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    String text = widget.texto;
    widget.data = {'has$text': _bandera, 'estado': 'No presenta sintoma'};
    return Container(
      //constraints: BoxConstraints(minHeight: 10,minWidth: 20,maxHeight: 50,maxWidth: 100),
      child: Container(
        width: mq.size.width * 0.9,
        height: mq.size.height * 0.15,
        child: Column(
          children: <Widget>[
            CheckboxListTile(
              value: _bandera,
              onChanged: (val) {
                setState(
                  () {
                    _bandera ? _bandera = false : _bandera = true;
                    widget.data['has$text'] = _bandera;
                    widget.data['estado'] =
                        _bandera ? '' : 'No presenta sintoma';
                  },
                );
              },
              title: Text(widget.texto),
            ),
            SliderWidget(_bandera, widget.data),
          ],
        ),
      ),
    );
  }
}

class SliderWidget extends StatefulWidget {
  final bandera;
  final data;

  SliderWidget(this.bandera, this.data);
  @override
  _SiderWidgetState createState() => _SiderWidgetState();
}

class _SiderWidgetState extends State<SliderWidget> {
  int valueHolder = 1;
  final mapa = {
    1: 'Peor que ayer',
    2: 'Igual que ayer',
    3: 'Mejor que ayer',
  };

  @override
  Widget build(BuildContext context) {
    if (widget.bandera) {
      widget.data['estado'] = mapa[valueHolder];
    } else {
      widget.data['estado'] = 'No presenta Sintoma';
    }
    final mq = MediaQuery.of(context);
    return Container(
      width: mq.size.width * 0.9,
      //height: 174,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            mapa[valueHolder],
            style: TextStyle(fontSize: 15),
          ),
          Container(
            width: mq.size.width * 0.5,
            child: Slider(
              value: valueHolder.toDouble(),
              min: 1,
              max: 3,
              divisions: 2,
              activeColor: Colors.green,
              inactiveColor: Colors.grey,
              // label: '${valueHolder.round()}',
              onChanged: widget.bandera
                  ? (double newValue) {
                      setState(() {
                        valueHolder = newValue.round();
                        widget.data['estado'] = mapa[valueHolder];
                      });
                    }
                  : null,
              semanticFormatterCallback: (double newValue) {
                return '${newValue.round()}';
              },
            ),
          ),
        ],
      ),
    );
  }
}
