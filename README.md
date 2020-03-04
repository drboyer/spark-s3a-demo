# spark-s3-demo

⚠️ _This application does not currently work successfully, it was created for debugging/help purposes. If you have an idea what's wrong, please feel free to submit an issue/PR or contact me. I'd be most grateful!_ 💛

This repo is a proof of concept that runs [Spark](https://spark.apache.org ) within a Docker container where it can interface with S3.

It uses

* Ubuntu 18.04 base image with OpenJDK 8 and Python 3.6
* Spark 2.4.5
* Hadoop 2.7.3 (which I believe is the version the Spark distribution I used was built with)

## Notes

This repo configuration is derived from https://github.com/NetAppEMEA/kubernetes-netapp

```
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```