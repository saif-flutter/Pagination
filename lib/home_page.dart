import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'controller/pagination_cubit.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final RefreshController controller = RefreshController(initialRefresh: true);


  @override
  void initState() {
    super.initState();

    context.read<PaginationCubit>().getPages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text('Pagination'),
      ),


      body: BlocBuilder<PaginationCubit, PaginationState>(
        builder: (context, state) {
          if(state is PaginationInitial) {
            return const Center(
                child: CircularProgressIndicator()
            );
          }
          /// Loaded State

          if (state  is PaginationLoadedState)
            {

              return SmartRefresher(
                controller: controller,
                enablePullDown: false,
                enablePullUp: true,

                footer: CustomFooter(
                  builder: ( context, mode){
                    Widget body ;
                    if(mode==LoadStatus.idle){
                      body = const CupertinoActivityIndicator();
                    }
                    else if(mode==LoadStatus.loading){
                      body =  const CupertinoActivityIndicator();
                    }
                    else if(mode == LoadStatus.failed){
                      body = const Text("Load Failed!Click retry!");
                    }
                    else if(mode == LoadStatus.canLoading){
                      body = const Text("release to load more");
                    }
                    else{
                      body = const Text("No more Data");
                    }
                    return SizedBox(
                      height: 55.0,
                      child: Center(child:body),
                    );

                  }

                ),

                onLoading: ()async{
                  ///
                  context.read<PaginationCubit>().getPages(isRefresh: false);
                  controller.loadComplete();
                  // if(result != null){
                  //   controller.loadComplete();
                  //
                  // }


                },
                child: ListView.separated(
                    itemCount: state.passengerModel.data!.length,
                    itemBuilder: (context,index){

                      var data = state.passengerModel.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.grey,
                      height: 150,
                      width: 180,
                      child: ListTile(
                        leading: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            '${index+1}',style: const TextStyle(
                            fontSize: 16,fontWeight: FontWeight.bold
                          ),),
                        ),
                         title: Text(data.name!),
                         trailing: Text(
                           textAlign: TextAlign.center,
                           data.airline![0].name.toString(),style: const TextStyle(
                           fontWeight: FontWeight.bold,color: Colors.black,fontSize: 16
                         ),),
                        subtitle: Text(data.airline![0].country.toString()),
                      ),
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) =>const Divider(),),
              );
            }
/// Error State
          else {
            return const Center(
              child: Text('Data Not Found'),
            );
          }
        },













      ),


    );
  }
}
