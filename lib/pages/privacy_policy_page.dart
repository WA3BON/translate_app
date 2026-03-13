import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy")),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800,
          ),
          child: const SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Text(
              '''
Privacy Policy（プライバシーポリシー）
最終更新日: 2026年3月

Traductor Lav（以下、「本アプリ」） は、ユーザーのプライバシーを尊重し、
個人情報の保護に努めます。
本ポリシーでは、本アプリにおける情報の取り扱いについて説明します。

■ 1. 収集する情報

本アプリは以下の情報を取得する場合があります。

・ユーザーが入力した翻訳テキスト
・アプリの利用状況に関する匿名データ

本アプリは、氏名・住所・電話番号などの個人情報を収集することはありません。

■ 2. 情報の利用目的

送信されたテキストは以下の目的でのみ利用されます。

・翻訳機能の提供
・翻訳結果の生成

本アプリは、ユーザーの入力内容を保存・蓄積しません。

■ 3. 第三者サービスについて

本アプリは翻訳機能を提供するために以下の外部サービスを利用しています。

・Amazon Web Services (AWS)
・Amazon Translate

ユーザーが入力したテキストは、翻訳処理のために
AWSのサーバーへ送信される場合があります。

AWSのプライバシーポリシーについては以下をご確認ください。

https://aws.amazon.com/privacy/

■ 4. データの保存について

本アプリは翻訳テキストの内容を保存しません。

ただし、サービス利用量を管理する目的で
匿名の利用カウントデータを保存する場合があります。

保存される情報には個人を特定できる情報は含まれません。

■ 5. セキュリティ

本アプリはデータ通信を安全に行うため、
HTTPS通信を使用しています。

■ 6. 利用状況の分析

本アプリはサービス改善のため、
匿名の利用データを収集する場合があります。

この情報には個人を特定する情報は含まれません。

■ 7. プライバシーポリシーの変更

本ポリシーは必要に応じて変更される場合があります。
変更後の内容は本アプリ内または公式ページにて告知します。

■ 8. お問い合わせ

本ポリシーに関するお問い合わせは、アプリの公開ページまたは配布元を通じてご連絡ください。


''',
              style: TextStyle(fontSize: 16, height: 1.7),
            ),
          ),
        ),
      ),
    );
  }
}
