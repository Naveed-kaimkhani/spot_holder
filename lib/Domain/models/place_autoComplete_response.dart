
import 'dart:convert';
class PlaceAutoCompleteResponse {
  final String status;
  final List<AutoCompletePrediction> predictions;

  PlaceAutoCompleteResponse({
    required this.status,
    required this.predictions,
  });
factory PlaceAutoCompleteResponse.fromJson(Map<String, dynamic> json) {
  final List<dynamic> predictionList = json['predictions'] != null ? json['predictions'] : [];
  return PlaceAutoCompleteResponse(
    status: json['status'],
    predictions: predictionList
        .map((predictionJson) => AutoCompletePrediction.fromJson(predictionJson))
        .toList(),
  );
}

static PlaceAutoCompleteResponse parseAutoCompleteResult(String responseBody){
final parsed= json.decode(responseBody).cast<String,dynamic>();
print("parsed");
print(parsed);
return PlaceAutoCompleteResponse.fromJson(parsed);
}

}
class AutoCompletePrediction {
  final String description;
  final String placeId;
  final String reference;
  final StructuredFormatting structuredFormatting;

  AutoCompletePrediction({
    required this.description,
    required this.placeId,
    required this.reference,
    required this.structuredFormatting,
  });

  factory AutoCompletePrediction.fromJson(Map<String, dynamic> json) {
    return AutoCompletePrediction(
      description: json['description'],
      placeId: json['place_id'],
      reference: json['reference'],
      structuredFormatting:
          StructuredFormatting.fromJson(json['structured_formatting']),
    );
  }
}

class StructuredFormatting {
  final String mainText;
  // final String secondaryText;

  StructuredFormatting({
    required this.mainText,
    // required this.secondaryText,
  });

  factory StructuredFormatting.fromJson(Map<String, dynamic> json) {
    return StructuredFormatting(
      mainText: json['main_text'],
      // secondaryText: json['secondary_text'],
    );
  }
}

