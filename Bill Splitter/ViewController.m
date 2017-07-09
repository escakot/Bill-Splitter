//
//  ViewController.m
//  Bill Splitter
//
//  Created by Errol Cheong on 2017-07-09.
//  Copyright © 2017 Errol Cheong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UISlider *numberOfPeopleSplitting;
@property (weak, nonatomic) IBOutlet UISlider *tipPercentageSlider;
@property (weak, nonatomic) IBOutlet UILabel *splitBillAmount;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPeopleSplittingLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.billAmountTextField.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self calculateSplitBill];
    [textField resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self calculateSplitBill];
    [textField resignFirstResponder];
    return YES;
}

- (void)calculateSplitBill{
    float percentageTip = 1 + (self.tipPercentageSlider.value / 100);
    float totalBill = ([self.billAmountTextField.text floatValue] * percentageTip)/self.numberOfPeopleSplitting.value;
    NSNumber *splitBill = [NSDecimalNumber numberWithFloat:totalBill];
    NSString *splitBillText = [NSNumberFormatter localizedStringFromNumber:splitBill numberStyle:NSNumberFormatterCurrencyStyle];
    self.splitBillAmount.text = splitBillText;
}
- (IBAction)splitBillSlider:(UISlider *)sender {
    NSInteger sliderValue = lroundf(sender.value);
    [sender setValue:sliderValue animated:YES];
    self.numberOfPeopleSplittingLabel.text =
    [NSString stringWithFormat:@"Number of People Splitting: %li", sliderValue];
    [self calculateSplitBill];
}
- (IBAction)tipPercentageSlider:(UISlider *)sender {
    NSInteger sliderValue = lroundf(sender.value);
    [sender setValue:sliderValue animated:YES];
    self.tipPercentageLabel.text =
    [NSString stringWithFormat:@"Percentage Tip: %li%%", sliderValue];
    [self calculateSplitBill];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
