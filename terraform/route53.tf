resource "aws_route53_zone" "eric-zone"{
    name="eric.tf-dunn.link"
}
resource "aws_route53_record" "record1"{
    zone_id=aws_route53_zone.eric-zone.zone_id
    type="A"
    name="eric.tf-dunn.link"
    alias{
        evaluate_target_health = false
        name                   = "d1ju4d5pioemg3.cloudfront.net"
        zone_id                = "Z2FDTNDATAQYW2"
    }
}
resource "aws_route53_record" "record2"{
    zone_id=aws_route53_zone.eric-zone.zone_id
    type="NS"
    name="eric.tf-dunn.link"
    records = [
          "ns-1166.awsdns-17.org.",
          "ns-1687.awsdns-18.co.uk.",
          "ns-409.awsdns-51.com.",
          "ns-667.awsdns-19.net.",
        ]
    ttl                              = 172800
    
}
resource "aws_route53_record" "record3"{
    zone_id=aws_route53_zone.eric-zone.zone_id
    type="SOA"
    name="eric.tf-dunn.link"
    records = ["ns-1687.awsdns-18.co.uk. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400",]
    ttl=900

}
resource "aws_route53_record" "record5"{
    zone_id="Z0125634M15R5UL5YG0F"
    type="NS"
    name="eric.tf-dunn.link"
    records = [
          "ns-1166.awsdns-17.org.",
          "ns-1687.awsdns-18.co.uk.",
          "ns-409.awsdns-51.com.",
          "ns-667.awsdns-19.net.",
        ]
    ttl                              = 300
    
}