#  MVVM With Repository Best Bractise News App 

## ViewModels

##### The public contract of a ViewModel is very important. You have to get it right (for more than one reason):

1- It should be pluggable on any View, i.e. it is not the way a View is built that is going to define the public contract of a ViewModel. As a reminder, it’s the View that owns the ViewModel. In other words, the View is aware of the ViewModel, not the other way around.

2- It should be testable. In the end, one of the biggest benefits of the MVVM architecture is to make the business logic testable.

3- MVVM is Ҫ with binding mechanisms so let’s leverage that with RxSwift.


##### A rule of thumb when designing a ViewModel contract is to always try to conceive the ViewModel as a simple black box that accepts inputs in order to produce outputs.

<img width="976" alt="Screen Shot 2020-11-17 at 1 17 03 PM" src="https://user-images.githubusercontent.com/11280137/99383908-45db1f00-28d7-11eb-8b05-05ceb7c35e87.png">

- Talking Rx, it means the ViewModel consumes Events (inputs) from some Streams (most of the time provided by the View) to compute output Streams (for the View).
- From there, a simple protocol can be written to express that any ViewModel should have Inputs and Outputs.

##Providing inputs to ViewModels

1- First approach — without Subjects
2- Second approach — with Subjects
 
### First approach — without Subjects (https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwiouLjVvIntAhW2WxUIHSI2Ap8QFjAAegQIBBAC&url=https%3A%2F%2Fmedium.com%2Fblablacar%2Frxswift-mvvm-66827b8b3f10&usg=AOvVaw2KPTOAIpw1Ac2Mv7D5EW8u)

- ViewModels are all about transforming Inputs into Outputs. Let’s add that to our ViewModelType protocol:

This makes it clear that at some point, the View has to provide all the Inputs (at the same time, we’ll get back to that) to the ViewModel to let it compute the Outputs

- lets think about input and output for login Screen and news List in this example

<img width="328" alt="Screen Shot 2020-11-17 at 1 22 04 PM" src="https://user-images.githubusercontent.com/11280137/99384311-e6314380-28d7-11eb-8e9a-5e0a4677863c.png">
<img width="682" alt="Screen Shot 2020-11-17 at 1 22 48 PM" src="https://user-images.githubusercontent.com/11280137/99384409-06f99900-28d8-11eb-8670-e880534d4759.png">
## second example 
<img width="404" alt="Screen Shot 2020-11-17 at 1 25 47 PM" src="https://user-images.githubusercontent.com/11280137/99384649-6a83c680-28d8-11eb-8cbf-cde75335567c.png">
<img width="538" alt="Screen Shot 2020-11-17 at 1 26 41 PM" src="https://user-images.githubusercontent.com/11280137/99384763-930bc080-28d8-11eb-9ce5-bccd99c982fe.png">

