class User_Type {
  final int ind, userFK, typeFK;

  const User_Type(this.ind, this.userFK, this.typeFK);

  Map<String, dynamic> toJson() => {
        'ind': ind.toString(),
        'userFK': userFK.toString(),
        'typeFK': typeFK.toString(),
      };
}
