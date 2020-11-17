#  MVVM With Repository Best Bractise News App (https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwiouLjVvIntAhW2WxUIHSI2Ap8QFjAAegQIBBAC&url=https%3A%2F%2Fmedium.com%2Fblablacar%2Frxswift-mvvm-66827b8b3f10&usg=AOvVaw2KPTOAIpw1Ac2Mv7D5EW8u)

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
 
### First approach — without Subjects 

- ViewModels are all about transforming Inputs into Outputs. Let’s add that to our ViewModelType protocol:

This makes it clear that at some point, the View has to provide all the Inputs (at the same time, we’ll get back to that) to the ViewModel to let it compute the Outputs

- lets think about input and output for login Screen and news List in this example

<img width="328" alt="Screen Shot 2020-11-17 at 1 22 04 PM" src="https://user-images.githubusercontent.com/11280137/99384311-e6314380-28d7-11eb-8e9a-5e0a4677863c.png">
<img width="682" alt="Screen Shot 2020-11-17 at 1 22 48 PM" src="https://user-images.githubusercontent.com/11280137/99384409-06f99900-28d8-11eb-8670-e880534d4759.png">
## second example 
<img width="404" alt="Screen Shot 2020-11-17 at 1 25 47 PM" src="https://user-images.githubusercontent.com/11280137/99384649-6a83c680-28d8-11eb-8cbf-cde75335567c.png">
<img width="538" alt="Screen Shot 2020-11-17 at 1 26 41 PM" src="https://user-images.githubusercontent.com/11280137/99384763-930bc080-28d8-11eb-9ce5-bccd99c982fe.png">

### Important Note : Pass the service on initalization Of View Model to make view model more configrable and to use it on unit testing (Dependency Injection)
<img width="722" alt="Screen Shot 2020-11-17 at 1 34 51 PM" src="https://user-images.githubusercontent.com/11280137/99385443-af5c2d00-28d9-11eb-9654-ff1d800c0c7e.png">
<img width="582" alt="Screen Shot 2020-11-17 at 1 33 34 PM" src="https://user-images.githubusercontent.com/11280137/99385359-8b98e700-28d9-11eb-9a67-75577a223f15.png">

### try use Repositry and implement ptotcols in Repositries to solve problem if your application work offline and  online or on unit testing 

<img width="560" alt="Screen Shot 2020-11-17 at 1 41 03 PM" src="https://user-images.githubusercontent.com/11280137/99386058-8be5b200-28da-11eb-9696-bf6ee843c8b6.png">


<img width="756" alt="Screen Shot 2020-11-17 at 1 42 27 PM" src="https://user-images.githubusercontent.com/11280137/99386189-bdf71400-28da-11eb-8dc1-0bb326cd79c1.png">

<img width="768" alt="Screen Shot 2020-11-17 at 1 40 27 PM" src="https://user-images.githubusercontent.com/11280137/99386001-753f5b00-28da-11eb-9137-1d4a4e1ade3d.png">

<img width="637" alt="Screen Shot 2020-11-17 at 1 39 39 PM" src="https://user-images.githubusercontent.com/11280137/99385941-59d45000-28da-11eb-86c0-51dee9625339.png">

<img width="646" alt="Screen Shot 2020-11-17 at 1 41 55 PM" src="https://user-images.githubusercontent.com/11280137/99386155-ad469e00-28da-11eb-9583-afc8d7d1c64b.png">
