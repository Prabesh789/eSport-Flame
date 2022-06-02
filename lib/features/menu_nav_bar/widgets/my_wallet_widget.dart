import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esport_flame/core/entities/base_state.dart';
import 'package:esport_flame/features/auth_screen/application/auth_controller.dart';
import 'package:esport_flame/features/menu_nav_bar/Model/ammount_model.dart';
import 'package:esport_flame/features/menu_nav_bar/widgets/add_balance_dialog.dart';
import 'package:esport_flame/features/menu_nav_bar/widgets/withdraw_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final logOutUserController =
    StateNotifierProvider.autoDispose<AuthController, BaseState>(
  authController,
);

class Mywallet extends ConsumerStatefulWidget {
  const Mywallet({Key? key, this.isFromAdminPannel = false}) : super(key: key);
  final bool? isFromAdminPannel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuNavBarState();
}

class _MenuNavBarState extends ConsumerState<Mywallet> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String userId = auth.currentUser!.uid;
  String nickname = '';

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _contactNocontroller = TextEditingController();
  final _passwordController = TextEditingController();
  final _nickNamecontroller = TextEditingController();

  bool obscureText = true;
  bool isLoading = false;
  String ammount = '0';

  AmmountModel ammountmodel = AmmountModel();

  @override
  void initState() {
    auth.authStateChanges().listen(
      (User? user) async {
        if (user != null) {
          if (mounted) {
            setState(() {
              userId = user.uid;
            });
          }
        }
      },
    );
    getAmmountDetail();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future profileUpdate() async {
    if (_formKey.currentState!.validate()) {
      final userRef = FirebaseFirestore.instance.collection('users');

      await userRef.doc(userId).update({
        'contactNo': _contactNocontroller.text.trim(),
        'email': _emailController.text.trim(),
        'nickName': _nickNamecontroller.text.trim(),
        'password': _passwordController.text.trim()
      });
    }
  }

  Future getAmmountDetail() async {
    await FirebaseFirestore.instance
        .collection('AccountBalance')
        .doc(userId)
        .get()
        .then((value) {
      ammountmodel = AmmountModel.fromMap(value.data()!);
      setState(() {
        ammount = ammountmodel.ammount!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    //button
    final buttonBalance = ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: const Color.fromARGB(255, 242, 230, 230), // Background color
      ),
      child: const Text(
        'Balance',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );

    final buttonWithdraw = ElevatedButton(
      onPressed: () {
        WithdrawAlertBox.showAlert(
          context: context,
          userId: userId,
          totalammount: ammount,
          mediaQuery: mediaQuery,
        );
      },
      style: ElevatedButton.styleFrom(
        primary: const Color.fromARGB(255, 254, 249, 249), // Background color
      ),
      child: const Text(
        'Withdraw',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
    final buttonAdd = ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: const Color.fromARGB(255, 242, 230, 230), // Background color
      ),
      child: const Text(
        'Add',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
    final withdrawButton = ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        primary: const Color.fromARGB(255, 242, 230, 230), // Background color
      ),
      child: const Text(
        'Add',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
    final totalBalance = Card(
      elevation: 5,
      color: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: ListTile(
        trailing: const Padding(
          padding: EdgeInsets.only(right: 15),
          // child: Icon(Icons.policy),
        ),
        onTap: () {},
        title: Text(
          'Total balance:',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Text(ammount),
      ),
    );
    final bonusBalance = Card(
      elevation: 5,
      color: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: ListTile(
        trailing: const Padding(
          padding: EdgeInsets.only(right: 15),
          // child: Icon(Icons.policy),
        ),
        onTap: () {},
        title: Text(
          'Bonus balance:',
          style: Theme.of(context)
              .textTheme
              .subtitle1
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: const Text('0.0'),
      ),
    );

    final addBalance = Card(
      elevation: 5,
      color: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Column(
          children: [
            Container(
              height: 30,
              alignment: Alignment.topLeft,
              // color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: const Text(
                'Deposite Balance',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 3, 3),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              // color: Colors.red,
              height: 15,
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: const Text('0.0'),
            ),
            const SizedBox(
              width: 50,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  AddBalance.showAlert(
                    context: context,
                    userId: userId,
                    totalammount: ammount,
                    mediaQuery: mediaQuery,
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Add'),
              ),
            )
          ],
        ),
      ),
    );

    //winning withdraw
    final withdrawWinning = Card(
      elevation: 5,
      color: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Column(
          children: [
            Container(
              height: 30,
              alignment: Alignment.topLeft,
              // color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: const Text(
                'Winning Balance',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 3, 3),
                ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              // color: Colors.red,
              height: 15,
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: const Text('0.0'),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  WithdrawAlertBox.showAlert(
                    context: context,
                    userId: userId,
                    totalammount: ammount,
                    mediaQuery: mediaQuery,
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text('Withdraw'),
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: buttonBalance),
                const SizedBox(width: 10),
                Expanded(child: buttonWithdraw),
              ],
            ),
            const SizedBox(height: 10),
            totalBalance,
            const SizedBox(height: 10),
            addBalance,
            const SizedBox(height: 10),
            bonusBalance,
            const SizedBox(height: 10),
            withdrawWinning
          ],
        ),
      ),
    );
  }
}
