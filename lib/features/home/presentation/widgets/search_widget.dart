
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/features/home/presentation/cubit/recipes_bloc.dart';
import 'package:recipe_app/features/home/presentation/cubit/recipes_event.dart';
import 'package:recipe_app/features/home/presentation/widgets/search_input_text_field.dart';
import 'package:recipe_app/features/home/presentation/widgets/search_type_selector.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  String searchType = 'name'; 
  TextEditingController searchFieldController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchTypeSelector(
          selectedType: searchType,
          
          onTypeChanged: (newType) {
            setState(() {
              searchType = newType;
            });
          },
        ),
        Row(
          children: [
            Expanded(
              child: SearchInputField(
                controller: searchFieldController,
                searchType: searchType,
              ),
            ),
             IconButton(onPressed: (){
              if(searchFieldController.text.isNotEmpty) {
                BlocProvider.of<RecipesBloc>(context).add(SearchByNameOrIngradientEvent(query:searchFieldController.text, isSearchByName: searchType=='name'?true:false));
              }
             }, icon: const Icon(Icons.search))
          ],
        ),
       
      ],
    );
  }
}