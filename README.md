# spark-s3a-demo

⚠️ _The docker images/configuration provided here are for demonstration purposes only. They have not been vetted for production use._

This repo is a proof of concept [Spark](https://spark.apache.org ) distribution within a Docker container that can interface with S3 (or S3-compatible filesystems using S3A).

It uses

* Ubuntu 18.04 base image with OpenJDK 8 and Python 3.6
* Spark 2.4.5
* Hadoop 3.1.3

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