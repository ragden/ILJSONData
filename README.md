# ILJSONData

ILJSONData it's a simply JSON-Object matcher, this project is under development. 
If you find a bug please open an issue, if you have a feature request, open an issue.

If in JSON are more keys than properties in model, Don't worry! ILJSONData doesn't crash and notifies to model with method:

```objc
- (void) errorMatchingForKey: (NSString*) key withKeyData: (id) data{
  //do some stuff
}
```
what is the key that can't be matched.


You have an example in the project.

Note that model properties must be NSString(for strings), NSNumber(integers, floats, doubles, boolean), NSArray and ILJSONData subclass.

Enjoy it!
