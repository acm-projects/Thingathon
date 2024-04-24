from flask import Flask, request, jsonify
import base64
from ultralytics import YOLO

def hasThing(thing,link):
    model = YOLO("yolov8n.pt", "v8")
    # print(model.names)
    results = model(source = link, conf=0.5, save=False)
    for box in results[0].boxes:
        class_id = results[0].names[box.cls[0].item()]
        if class_id.find(thing) != -1:
            return True
        return False


app = Flask(__name__)

@app.route("/process-request", methods=["POST"])
def process_request():
    try:
        #Get base64 image string and thing from the request
        data = request.json
        base64_string = data.get('base64', '')
        thing = data.get('thing', '')
        image_bytes = base64.b64decode(base64_string)
        with open("copy_of_image.jpg", "wb") as f:
            f.write(image_bytes)
        #Process
        if hasThing(thing, "./copy_of_image.jpg"):
            return jsonify({'bool': "True"})
        else:
            return jsonify({'bool': "False"})

    except Exception as e:
        print("Error decoding base 64 image: ", e)
        return None


if __name__ == '__main__':
    app.run(host='10.169.173.153')
