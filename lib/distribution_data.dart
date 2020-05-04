library distribution_data;

class DistributionData {
  Map<String, double> distData = Map();
  void addVersionData({String osVersion, double osDist}) {
    distData[osVersion] = osDist;
  }

  int getLength() {
    return distData.length;
  }
}
