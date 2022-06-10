appBar: AppBar(
  leading: BackButton(
    onPressed: () => Navigator.pop(context, messages),
  ),
),