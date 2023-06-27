import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nwesapp/layout/shopapp/cubit/cubit.dart';
import 'package:flutter_nwesapp/layout/shopapp/cubit/states.dart';
import 'package:flutter_nwesapp/model/shop_favorite_model.dart';
import 'package:flutter_nwesapp/shared/components/conditional.dart';
class FavoritsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener:(context,state){},
        builder: (context,state)=>ConditionalBuilder(
          condition: ShopCubit.get(context).shopCategoriesModel!=null,
          builder:ListView.separated(
              itemBuilder: (context,index)=>FavoriteItem(
                ShopProduct: ShopCubit.get(context).shopFavoriteModel?.data!.data![index],
              ),
            separatorBuilder:(context,index)=>Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          itemCount: ShopCubit.get(context).shopFavoriteModel!.data!.data!.length,
          ),
          fallback: Center(child: CircularProgressIndicator()),
        ),

    );
  }
}
class FavoriteItem extends StatelessWidget {
  FavoriteProduct? ShopProduct;
  FavoriteItem({
    this.ShopProduct,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            children: [
              Image(
                image: NetworkImage(ShopProduct!.products.image),
                height: 120.0,
                width: 120.0,
                fit:BoxFit.cover,
              ),
              SizedBox(
                width:20.0 ,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ShopProduct!.products.name,
                      style:Theme.of(context).textTheme.subtitle1,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          ShopProduct!.products.price,
                          style:Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: (){
                            ShopCubit.get(context).changeFavoriteData(ShopProduct!.products.id);
                          },
                          icon:Icon(Icons.favorite),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
