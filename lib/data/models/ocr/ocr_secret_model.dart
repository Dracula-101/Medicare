class OCRSecret {
  String? projectId;
  String? projectName;
  String? processorId;
  String? processorLocation;
  String? accessToken;

  OCRSecret({
    this.projectId,
    this.projectName,
    this.processorId,
    this.processorLocation,
    this.accessToken,
  });

  OCRSecret.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    projectName = json['project_name'];
    processorId = json['processor_id'];
    processorLocation = json['processor_location'];
    accessToken = json['api_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['project_id'] = projectId;
    data['project_name'] = projectName;
    data['processor_id'] = processorId;
    data['processor_location'] = processorLocation;
    data['api_key'] = accessToken;
    return data;
  }
}
