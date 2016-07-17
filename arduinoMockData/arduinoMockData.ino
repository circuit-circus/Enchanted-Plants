
long randNo;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  randNo = random(0, 12);
  Serial.println(randNo);
  delay(random(100, 3000));
}
