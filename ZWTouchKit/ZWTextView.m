#import "ZWTextView.h"

@interface ZWTextView() {
	
}

- (void)ZWTextView_init;
- (void)textDidChangeNotification:(NSNotification *)pNotification;

@end
@implementation ZWTextView

#pragma mark - Properties

@synthesize placeholder;
@synthesize placeholderColor;
@synthesize placeholderLabel;

- (void)setPlaceholder:(NSString *)pValue {
	placeholder = [pValue copy];
	self.placeholderLabel.text = pValue;
	[self.placeholderLabel setNeedsLayout];
	[self.placeholderLabel setNeedsDisplay];
	[self setNeedsLayout];
}
- (void)setFont:(UIFont *)pValue {
	[super setFont:pValue];
	self.placeholderLabel.font = self.font;
}

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)pFrame {
	if((self = [super initWithFrame:pFrame])) {
		[self ZWTextView_init];
	}
	return self;
}
- (id)initWithCoder:(NSCoder *)pCoder {
	if((self = [super initWithCoder:pCoder])) {
		[self ZWTextView_init];
	}
	return self;
}
- (void)ZWTextView_init {
	placeholder = @"";
	placeholderColor = [UIColor colorWithRed:.701960784 green:.701960784 blue:.701960784 alpha:1.0];
	
	placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, self.bounds.size.width - 16.0, 0.0)];
	placeholderLabel.lineBreakMode = UILineBreakModeWordWrap;
	placeholderLabel.numberOfLines = 0;
	placeholderLabel.font = self.font;
	placeholderLabel.backgroundColor = [UIColor clearColor];
	placeholderLabel.textColor = placeholderColor;
	placeholderLabel.text = placeholder;
	[placeholderLabel sizeToFit];
	[self addSubview:placeholderLabel];
	[self sendSubviewToBack:placeholderLabel];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeNotification:) name:UITextViewTextDidChangeNotification object:self];
	[self textDidChangeNotification:nil];
}

#pragma mark - Notifications

- (void)textDidChangeNotification:(NSNotification *)pNotification {
	if(self.placeholder.length > 0) {
		if ([self.text length] == 0) {
			self.placeholderLabel.alpha = 1.0;
		} else {
			self.placeholderLabel.alpha = 0.0;
		}
	}
}

#pragma mark - UIView

- (void)layoutSubviews {
	[super layoutSubviews];
	CGRect r = self.placeholderLabel.frame;
	r.size.width = self.bounds.size.width - 16;
	self.placeholderLabel.frame = r;
}

#pragma mark - Dealloc

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
}

@end
