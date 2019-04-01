/**
 * This program runs a simple simulation.
 * Welcome to world where it is not okay to be a circle!
 * 
 * @author Aarsh Patel
 */

//canvas and c let me interact with the webpage, the variable connects to the HTML page protectCircle.html
let canvas = document.querySelector("canvas");
let c = canvas.getContext("2d");

//this sets the html canvas to the full size of the webpage
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

//I set a predefined size for circle and square such that sizes are propotional at different screens and resolutions 
canvisSize = canvas.width*canvas.height;
circleRadius = Math.round(Math.sqrt((canvisSize * (2827.43/3343113))/Math.PI)); //area at 0.08454% of total pixels
squareSize = Math.round(Math.sqrt(canvisSize * (3600/3343113))); //area at 0.10768% of total pixels
speed = canvisSize*(5/3343113); //speed of circle and squares relative to screen size and resolution

//minimum speed required must be 1.1 
if(speed<=1){
    speed = 1.1; 
}

//this variable records the score
let score = 0;
//these variables record the direction in which the circle is traveling
let up = false;
let down = false;
let left = false;
let right = false;
let shoot = false;
let shootup = false;
let shootdown = false;
let shootleft = false;
let shootright = false;


let animate = true;

//this records instaneous x and y position of the circle
let xCord =[];
let yCord =[];

//this array stores the object:square to record the spawned squares
let array = [];



//IGNORE THIS CODE 
    // c.beginPath();
    // c.moveTo(50,50);
    // c.lineTo(100,100);
    // c.strokeStyle = "black";
    // c.stroke();

    // c.beginPath();
    // c.arc(1000,500, 100, 0, Math.PI*2, false);
    // c.strokeStyle = "red";
    // c.stroke();


//this creates the object:square
function square( x, y, size, dx, dy){
    //this records property of squares, x: x position, y: y position, size: length and width, dx: x speed, dy: y speed: xCordSquare: records ALL x position (perimeter) yCordSquare: records ALL y position (perimeter)
    this.x = x;
    this.y = y;
    this.size = size;
    this.dx = dx;
    this.dy = dy;
    this.xCordSquare = xCordSquare = [];
    this.yCordSquare = yCordSquare  = [];

    //this function determine ALL positions surrounding the square (finds the coordinates of the perimeter), note values are rounded
    this.determineAllPointsForSquare = function (){
        
        for(let i = 0; i <= this.size; i++){
            this.xCordSquare[i] = Math.round(i + this.x);
            this.yCordSquare[i] = Math.round(i + this.y);
        }
    

    }

    //this function changes dx and dy (allows movement)
    this.animate = function(){
      
      
        //fillRect draws rectangle with properties
        c.fillRect(this.x, this.y, this.size, this.size);
      
        //checks if square hits vertical borders, and if so, then reverses speed
        if(this.x + this.size> innerWidth ||this.x <0 ){
            this.dx = -this.dx;
        }
        
        //check if square hits horizontal borders, and if so, then reverses speed
        if(this.y + this.size> innerHeight || this.y<0){
            this.dy = -this.dy;
        }
        
        //animates the movement in x and y directions
        this.x+= this.dx;
        this.y+=this.dy;

        //shooting mechanic
        //checks direction, and checks if any sqaure is in x and y interval of bullet line
        //for shooting upwards
        if(shootup == true){
            for(let i = 0; i<array.length; i++){
                sq = array[i]
    
                    if(sq.y <= player.y){
                        if(sq.x-1<=player.x && (sq.x+sq.size+1)>=player.x){ 
                            console.log("hit")
                            array.splice(i,1);
                        }
                    }
                shootup = false;
            
                } 
        }
        //for shooting downwards
        if(shootdown == true){
            for(let i = 0; i<array.length; i++){
                sq = array[i]
    
                    if(sq.y >= player.y){
                        if(sq.x-1<=player.x && (sq.x+sq.size+1)>=player.x){ 
                            console.log("hit")
                            array.splice(i,1);
                        }
                    }
                shootdown = false;
            
                } 
        }
        //for shooting left
        if(shootleft == true){
            for(let i = 0; i<array.length; i++){
                sq = array[i]
    
                    if(sq.x <= player.x){
                        if(sq.y-1<=player.y && (sq.y+sq.size+1)>=player.y){ 
                            console.log("hit")
                            array.splice(i,1);
                        }
                    }
                shootleft = false;
            
                } 
        }
        //for shooting right
        if(shootright == true){
            for(let i = 0; i<array.length; i++){
                sq = array[i]
    
                    if(sq.x >= player.x){
                        if(sq.y-1<=player.y && (sq.y+sq.size+1)>=player.y){ 
                            console.log("hit")
                            array.splice(i,1);
                        }
                    }
                shootright = false;
            
                } 
        }
        
        //records perimeter value of square
        this.determineAllPointsForSquare();
        
        //x and y are booleans, if they are true then it means the the circle and the square share the same postion, meaning the game is over
        let x = false;
        let y = false;

        //these for loops checks all x and y coordinates of the square and circle
        //refer to function determineAllPoints() to see how x and y position of circle is obtained
        for(let i = 0; i < xCord.length; i+=3){
            for(let j = 0; j < this.xCordSquare.length; j++){
                //compares x position
                if(xCord[i] == this.xCordSquare[j]){
                    x = true;
                }

                //compares y position
                if( yCord[i] == this.yCordSquare[j]){
                    y = true;
                }  
   
                //checks to see if x and y are in the same position, and if so then stops the game
                if(x == true && y == true){
                    document.querySelector('.hide').style.display = 'flex';
                    document.getElementById('highScore').innerHTML = localStorage.getItem('highScore');
                    animate = false;
                }

            }
        }
        

    }
}


//this function determines all values surrounding the circle (like perimeter), with the use of trig 
//-->sin for x position -->cos for y position
//Inside has confusing pi stuff to convert degrees to radians (i like working with degrees), also values are rounded
function determineAllPoints(){
    for(let i = 0; i < 361; i++){

        xCord[i] = Math.round((circleRadius * Math.cos(i*((Math.PI)/180))) +player.x);
        yCord[i] = Math.round((circleRadius * Math.sin(i*((Math.PI)/180))) + player.y);

    }
}



// this is object: circle with properties
function circle(x,y,radius, walk){
    // x: x position, y: y position, radius: the distance from the outerside to center, walk: the number of pixels in which it moves (speed)
    this.x =x;
    this.y =y;
    this.radius=radius;
    this.walk = walk;

    //the go function animates the circle object
    this.go = function (){
        //c.blah blah is for drawing the circle from arc
        c.beginPath();
        c.strokeStyle = "green";
        c.fillStyle = "green";
        c.arc(this.x, this.y, this.radius,0,Math.PI*2, false);
        c.fill();
        c.stroke();

        //this controls the circle from key inputs and changes direction of circle with help of boolean
        //checks to see if center of circle is radius length away from given border
        //draws a line for the bullet in terms of direction 
            if(up == true && this.y >=circleRadius){
                this.y -= walk;
                if(shoot == true){
                        c.beginPath();
                        c.moveTo(this.x,this.y);
                        c.lineTo(this.x,0);
                        c.strokeStyle = "orange";
                        c.stroke();
                    shoot = false;

                }
            }
            if(down == true && this.y <= (innerHeight-circleRadius)){
                this.y += walk;
                if(shoot == true){
                    c.beginPath();
                    c.moveTo(this.x,this.y);
                    c.lineTo(this.x,innerHeight);
                    c.strokeStyle = "orange";
                    c.stroke();
                shoot = false;

                }
            }
            if( left == true && this.x >= circleRadius){
                this.x -= walk;
                if(shoot == true){
                    c.beginPath();
                    c.moveTo(this.x,this.y);
                    c.lineTo(0,this.y);
                    c.strokeStyle = "orange";
                    c.stroke();
                shoot = false;

                }
            }
            if( right == true && this.x <= (innerWidth-circleRadius)){
                this.x += walk;
                if(shoot == true){
                    c.beginPath();
                    c.moveTo(this.x,this.y);
                    c.lineTo(innerWidth,this.y);
                    c.strokeStyle = "orange";
                    c.stroke();
                shoot = false;

                }
            }


    }
   
    
}

//creates one new player, the option to create more than one player is available for future expansion
let player = new circle(innerWidth/2 +30,innerHeight/2,circleRadius,speed*2);





//this function adds a square to the array
function addSquare(){
  
    //go see object: square
    let x = 0;
    let size = squareSize;
    let dx = 0;
    let dy = 0;

    //uses random function to decide where the square should spawn
    let side = Math.round(Math.random()*5);

    //spawns at some random position at the top
    if(side == 1){
        x = Math.random() * innerWidth;
        y=0;
    }

    //spawns at some random position at the right side
    else if(side == 2){
        x = innerWidth;
        y = Math.random()*innerHeight;
    }

    //spawns at some random position at the bottom
    else if(side==3){
        x = Math.random()*innerWidth;
        y = innerHeight;
    }

    //spawns at some random position at the left side
    else{
        x = 0;
        y = Math.random()*innerHeight;

    }

    //uses random function to assign random speed of square, the while function ensures that the speed is not 0
    while(dx==0){
        dx = (Math.round((Math.random()-0.5)*speed));
    }
    while (dy==0){
        dy = dx = (Math.round((Math.random()-0.5)*speed));
    }
   
    //sometimes the square spawn on the border, this insures that it spawns INSIDE the border/canvas
    if(x+size > innerWidth){
        x = innerWidth - size;
    }
    if(y+size > innerHeight){
        y = innerHeight - size;
    }

    //makes the square object and adds it to the array with .push method
    let s = new square(x,y,size, dx, dy);
    array.push(s);
   
    //tracks how many squares are present in the array/screen for score keeping
    score++;

    //updates high score locally on browser 
    if(score>=localStorage.getItem('highScore')){
        let store = score.toString();
        localStorage.setItem("highScore", store);
    }
}


//this function removes all the squares when the game is over
function removeSquares(){
    for(let i = 0; i < array.length; i++){
                      
        array[i] = NULL;
        
      }     

}




//this function gets key inputs from keyboard
//uses arrow keys or wasd keys
 window.addEventListener ('keydown', function(event)
    { 
       // console.log(event);
        if(event.key == "ArrowUp" ||event.key == "w"){
            up =true;
            down=false;
            left=false;
            right = false;  
        }
        
        if(event.key == "ArrowDown" ||event.key == "s"){
            down = true;
            up=false;
            left=false;
            right = false;  
        }
        if(event.key == "ArrowLeft" ||event.key == "a"){
            left = true;
            up=false;
            down=false;
            right = false;  
        }
        if(event.key == "ArrowRight" ||event.key == "d"){
            right = true;
            down=false;
            left=false;
            up = false;  
        }

    });

    //************************Touch Gesture Support from Import **********************************/
    //https://gist.github.com/SleepWalker/da5636b1abcbaff48c4d
    let pageWidth = window.innerWidth || document.body.clientWidth;
    let treshold = Math.max(1,Math.floor(0.01 * (pageWidth)));
    let touchstartX = 0;
    let touchstartY = 0;
    let touchendX = 0;
    let touchendY = 0;
    
    const limit = Math.tan(45 * 1.5 / 180 * Math.PI);

    
    window.addEventListener('touchstart', function(event) {
        touchstartX = event.changedTouches[0].screenX;
        touchstartY = event.changedTouches[0].screenY;
    }, false);
    
    window.addEventListener('touchend', function(event) {
        touchendX = event.changedTouches[0].screenX;
        touchendY = event.changedTouches[0].screenY;
        handleGesture(event);
    }, false);
    
    function handleGesture(e) {
        let x = touchendX - touchstartX;
        let y = touchendY - touchstartY;
        let xy = Math.abs(x / y);
        let yx = Math.abs(y / x);
        if (Math.abs(x) > treshold || Math.abs(y) > treshold) {
            if (yx <= limit) {
                if (x < 0) {
                    left = true;
                    up=false;
                    down=false;
                    right = false;
                } else {
                    right = true;
                    down=false;
                    left=false;
                    up = false;
                }
            }
            if (xy <= limit) {
                if (y < 0) {
                    up =true;
                    down=false;
                    left=false;
                    right = false;  
                } else {
                    down = true;
                    up=false;
                    left=false;
                    right = false;
                }
            }
        } else {
            shoot = true;
            if(up == true){
                shootup = true;
            }
            if(down == true){
                shootdown = true;
            }
            if(left == true){
                shootleft = true;
            }
            if(right == true){
                shootright = true;
            }
        }
    }
    /*******************************************************************************/

//when space bar is pressed, shoot is activated
    window.addEventListener ('keypress', function(event)
    { 
        if(event.keyCode == 32){
            shoot = true;
            if(up == true){
                shootup = true;
            }
            if(down == true){
                shootdown = true;
            }
            if(left == true){
                shootleft = true;
            }
            if(right == true){
                shootright = true;
            }
        }

    });



//timestamp record current time in a integer
let timeStamp = Date.now();
let laterTime = 0;

//this is where the ANIMATION happens
function move(){
    //calls function to find all points of circle
    determineAllPoints();
    
    //for every frame, refreshed the canvas to delete old stuff
    c.clearRect(0, 0, innerWidth, innerHeight);

    //assigns value to later time
     laterTime = Date.now();
     
     //assigns color to circle
     c.strokeStyle = "green";
     c.fillStyle = "green";
     //calls the animation funciton for circle
     player.go();

     //determines when the add each square, for now it is 1000 time units (lol idk the units)
    let timeInterval = 1000;

    //after 2000000 time units, the spawn rate will become faster and game will become harder
    if((laterTime - timeStamp) > 200000){
        timeInterval = timeInterval/2;
    }

    //Adds a square at given time interval
    //Note i added 20, when frame refreshed it refreshes every 16.667 time units (sometimes faster depending on load), so by adding 20, this ensures that a square is added
    for(let z = timeInterval; z < timeInterval+20; z++){ //so in this case z will go from 1000 to 1020
        //first condition ensures not to add square when time =0 and the other condition checks for correct time interval
        if((laterTime - timeStamp)!= 0 && (laterTime - timeStamp)  % z == 0){
             addSquare();    
        }   
    }

    //this function animates every square in the array of square objects, also applies the red colour desgin
    for(let i = 0; i < array.length; i++){
         c.strokeStyle = "red";
         c.fillStyle = "red";
         array[i].animate();
    }
    
    //this displays the score on the canvas
    c.font = '150pt Tahoma';
    c.strokeStyle = 'blue';
    c.strokeText(" "+score,innerWidth/2 -110,innerHeight/2);

    

    //best thing ever 
   if(animate){ 
   requestAnimationFrame(move);
   }
}


//recursive to make frames 
move();

