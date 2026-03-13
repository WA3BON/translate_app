import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Terms of Service")),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 800,
          ),
          child: const SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Text(
              '''
Terms of Service（利用規約）
最終更新日: 2026年3月

この利用規約（以下、「本規約」）は、Traductor Lav（以下、「本アプリ」）の利用条件を定めるものです。
ユーザーは、本アプリを利用することにより、本規約に同意したものとみなされます。

■ 1. サービス内容

本アプリは、日本語とスペイン語の翻訳機能を提供するアプリケーションです。

翻訳結果は自動翻訳技術によって生成されるため、翻訳内容の正確性・完全性を保証するものではありません。

■ 2. 利用条件

ユーザーは、以下の行為を行ってはなりません。

・法令または公序良俗に違反する行為  
・本アプリの運営を妨害する行為  
・不正アクセスやシステムへの攻撃行為  
・他者の権利を侵害する行為  

■ 3. 翻訳結果の責任

本アプリで提供される翻訳結果は参考情報として提供されます。

翻訳結果の使用によって発生したいかなる損害についても、本アプリは責任を負いません。

■ 4. サービスの変更・停止

本アプリは、事前の通知なくサービス内容を変更または停止する場合があります。

■ 5. 免責事項

本アプリは以下について責任を負いません。

・翻訳内容の誤り  
・サービスの一時停止  
・外部サービスの障害  
・通信環境による不具合  

■ 6. 規約の変更

本規約は、必要に応じて変更される場合があります。  
変更後の規約は、本ページに掲載された時点で効力を持ちます。

■ 7. 準拠法

本規約は、日本法を準拠法とします。
''',
              style: TextStyle(fontSize: 16, height: 1.7),
            ),
          ),
        ),
      ),
    );
  }
}
