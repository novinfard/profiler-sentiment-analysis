import Cocoa
import CreateML

let paths = Bundle.main.paths(forResourcesOfType: "csv", inDirectory: nil)
paths.forEach { path in
	let url = URL(fileURLWithPath: path)
	let data = try MLDataTable(contentsOf: url)
	let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)
	let sentimentClassifier = try MLTextClassifier(trainingData: trainingData,
												   textColumn: "TEXT",
												   labelColumn: "result")
	// Training accuracy as a percentage
	let trainingAccuracy = (1.0 - sentimentClassifier.trainingMetrics.classificationError) * 100

	// Validation accuracy as a percentage
	let validationAccuracy = (1.0 - sentimentClassifier.validationMetrics.classificationError) * 100
	
	
	let filename = (path as NSString).lastPathComponent
	let fileExtention = (filename as NSString).pathExtension
	let filenameWithoutExt = (filename as NSString).deletingPathExtension
	print("\(filenameWithoutExt): training accuracy -> \(trainingAccuracy) validation accuracy ->\(validationAccuracy)")
	
	let metadata = MLModelMetadata(author: "Soheil Novinfard",
								   shortDescription: "A model trained to classify personality traits",
								   version: "1.0")
	
	
	let tempPath = (path as NSString).deletingLastPathComponent
	let playgroundPath = (tempPath as NSString).deletingLastPathComponent
	try sentimentClassifier.write(to: URL(fileURLWithPath: playgroundPath + filenameWithoutExt + ".mlmodel"),
								  metadata: metadata)

}
