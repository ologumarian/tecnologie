import 'package:documentive/providers/projects.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class NewProjectForm extends StatefulWidget {
  @override
  _NewProjectFormState createState() => _NewProjectFormState();
}

class _NewProjectFormState extends State<NewProjectForm> {
  final _formKey = GlobalKey<FormState>();

  var name = '';
  var description = '';
  var imageLink = '';

  var _isLoading = false;

  final _nameFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  //var per il fetch dell'immagine nella preview
  final _imageLinkController = TextEditingController();
  final _imageLinkFocusNode = FocusNode();

  @override
  void initState() {
    _imageLinkController.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageLinkFocusNode.removeListener(_updateImageUrl);
    //è importante rimuovere i FocusNode che si crea nel WidgetState per pulire la memoria
    _imageLinkController.dispose();
    _imageLinkFocusNode.dispose();
    _nameFocusNode.dispose();
    _descriptionFocusNode.dispose();

    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageLinkFocusNode.hasFocus) {
      if ((!_imageLinkController.text.startsWith('http') &&
              !_imageLinkController.text.startsWith('https')) ||
          (!_imageLinkController.text.contains('png') &&
              !_imageLinkController.text.contains('jpg') &&
              !_imageLinkController.text.contains('photo') &&
              !_imageLinkController.text.contains('image'))) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    _updateImageUrl();
    final isValid = _formKey.currentState.validate();
    if (!isValid) return;
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Projects>(context, listen: false).addProject(
        name: name,
        desc: description,
        imageLink: imageLink,
      );
    } catch (error) {
      //ritorna un Future
      await showDialog<Null>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Errore!'),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.error_outline,
                color: Colors.red,
              ),
              Text('Qualcosa è andato storto'),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Chiudi'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      key: ValueKey('name'),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(labelText: 'Nome Progetto'),
                      //per passare all'altro TextField con il pulsante next
                      textInputAction: TextInputAction.next,
                      focusNode: _nameFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_imageLinkFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Inserisci il nome del progetto';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    TextFormField(
                      key: ValueKey('imageLink'),
                      keyboardType: TextInputType.url,
                      decoration: InputDecoration(
                          labelText: 'URL immagine di copertina'),
                      textInputAction: TextInputAction.next,
                      controller: _imageLinkController,
                      focusNode: _imageLinkFocusNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(_descriptionFocusNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Inserisci un URL';
                        }
                        if (!value.startsWith('http') &&
                            !value.startsWith('https')) {
                          return 'Inserisci un URL valido';
                        }
                        if (!value.contains('png') &&
                            !value.contains('jpg') &&
                            !value.contains('image') &&
                            !value.contains('photo')) {
                          return 'Inserisci un URL di un immagine';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    TextFormField(
                      key: ValueKey('description'),
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      maxLength: 140,
                      decoration: InputDecoration(labelText: 'Descrizione'),
                      textInputAction: TextInputAction.newline,
                      focusNode: _descriptionFocusNode,
                      onFieldSubmitted: (_) => _saveForm(),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Inserisci una descrizione';
                        }
                        return null;
                      },
                      onSaved: (value) {},
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey[200],
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6,
                            color: Colors.black12,
                            offset: Offset(4, 4),
                          )
                        ],
                      ),
                      child: _imageLinkController.text.isEmpty
                          ? Center(child: Text('Inserisci un URL'))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                _imageLinkController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      child: Text('Crea Progetto'),
                      onPressed: () {
                        _saveForm();
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
